-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require "awful" -- Standard awesome library
local beautiful = require "beautiful" -- Theme handling library
local gears = require "gears"
local menubar = require "menubar"
local naughty = require "naughty" -- Notification library
local wibox = require "wibox" -- Widget and layout library

require "awful.autofocus"

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify {
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  }
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    }
    in_error = false
  end)
end
-- }}}

-- {{{ Monitors
local function configure_monitors()
  awful.spawn.easy_async_with_shell("xrandr", function(stdout)
    local current_output = nil

    for line in stdout:gmatch "[^\n]+" do
      local monitor = line:match "^([%w%-]+) connected"
      if monitor then
        current_output = monitor
      -- Check if this is a resolution line (starts with spaces)
      elseif current_output and line:match "^%s+%d+x%d+" then
        local resolution = line:match "^%s+(%d+x%d+)"

        -- Extract and sort refresh rates
        local rates = {}
        for rate in line:gmatch "(%d+%.%d+)" do
          table.insert(rates, tonumber(rate))
        end
        table.sort(rates, function(a, b) return a > b end)

        -- Apply if we have both
        if resolution and rates[1] then
          awful.spawn(string.format("xrandr --output %s --mode %s --rate %.2f", current_output, resolution, rates[1]))
        end

        -- Only process first resolution line per monitor
        current_output = nil
      end
    end
  end)
end
configure_monitors()
screen.connect_signal("added", configure_monitors)

-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
local terminal = os.getenv "TERMINAL" or "wezterm"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local mytextclock = wibox.widget.textclock()
local mymonthcalendar = awful.widget.calendar_popup.year()
mytextclock:connect_signal(
  "mouse::enter",
  function() mymonthcalendar:call_calendar(0, "tr", awful.screen.focused()) end
)
mytextclock:connect_signal(
  "button::press",
  function() mymonthcalendar:call_calendar(0, "tr", awful.screen.focused()) end
)
mymonthcalendar:attach(mytextclock, "tr")

local myvolume = wibox.widget.textbox()
local function update_volume()
  awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout) myvolume.text = stdout end)
end
update_volume()
myvolume:connect_signal("volume::update", function() update_volume() end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(
    gears.table.join(
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(1) end),
      awful.button({}, 5, function() awful.layout.inc(-1) end)
    )
  )

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
      end),
      awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    ),
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = gears.table.join(
      awful.button({}, 1, function(c)
        if c == client.focus then
          c.minimized = true
        else
          c:emit_signal("request::activate", "tasklist", { raise = true })
        end
      end),
      awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
      awful.button({}, 4, function() awful.client.focus.byidx(1) end),
      awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
    ),
  }

  -- Create the wibox and add widgets to it
  s.mywibox = awful.wibar { position = "top", screen = s }
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },

    s.mytasklist,

    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.textbox " ",
      myvolume,
      wibox.widget.textbox " ",
      awful.widget.watch("bash -c 'acpi -b | cut -d, -f1-2'", 60),
      mytextclock,
      wibox.widget.systray(),
      s.mylayoutbox,
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  awful.key(
    { modkey },
    "j",
    function() awful.client.focus.byidx(1) end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key(
    { modkey },
    "k",
    function() awful.client.focus.byidx(-1) end,
    { description = "focus previous by index", group = "client" }
  ),

  -- Layout manipulation
  awful.key(
    { modkey, "Shift" },
    "j",
    function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }
  ),
  awful.key(
    { modkey, "Shift" },
    "k",
    function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }
  ),
  awful.key(
    { modkey, "Control" },
    "j",
    function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }
  ),
  awful.key(
    { modkey, "Control" },
    "k",
    function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }
  ),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then client.focus:raise() end
  end, { description = "go back", group = "client" }),

  -- Standard program
  awful.key(
    { modkey },
    "Return",
    function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }
  ),
  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  awful.key(
    { modkey },
    "l",
    function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }
  ),
  awful.key(
    { modkey },
    "h",
    function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }
  ),
  awful.key(
    { modkey, "Shift" },
    "h",
    function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }
  ),
  awful.key(
    { modkey, "Shift" },
    "l",
    function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }
  ),
  awful.key(
    { modkey, "Control" },
    "h",
    function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }
  ),
  awful.key(
    { modkey, "Control" },
    "l",
    function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }
  ),
  awful.key({ modkey }, "space", function() awful.layout.inc(1) end, { description = "select next", group = "layout" }),
  awful.key(
    { modkey, "Shift" },
    "space",
    function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }
  ),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then c:emit_signal("request::activate", "key.unminimize", { raise = true }) end
  end, { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key(
    { modkey },
    "r",
    function() awful.screen.focused().mypromptbox:run() end,
    { description = "run prompt", group = "launcher" }
  ),

  awful.key(
    { modkey },
    "x",
    function()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval",
      }
    end,
    { description = "lua execute prompt", group = "awesome" }
  ),
  -- Menubar
  awful.key({ modkey }, "p", function() menubar.show() end, { description = "show the menubar", group = "launcher" }),

  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn.easy_async(
      "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-",
      function() myvolume:emit_signal "volume::update" end
    )
  end, { description = "lower volume", group = "system" }),

  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn.easy_async(
      "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
      function() myvolume:emit_signal "volume::update" end
    )
  end, { description = "raise volume", group = "system" }),

  awful.key({}, "XF86AudioMute", function()
    awful.spawn.easy_async(
      "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
      function() myvolume:emit_signal "volume::update" end
    )
  end, { description = "raise volume", group = "system" }),

  awful.key(
    {},
    "XF86MonBrightnessUp",
    function() awful.spawn "brightnessctl set +5%" end,
    { description = "raise brightness", group = "system" }
  ),

  awful.key(
    {},
    "XF86MonBrightnessDown",
    function() awful.spawn "brightnessctl set 5%-" end,
    { description = "lower brightness", group = "system" }
  ),

  awful.key({}, "Print", function() awful.spawn "flameshot gui" end)
)

local clientkeys = gears.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key(
    { modkey, "Control" },
    "Return",
    function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }
  ),
  awful.key({ modkey }, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "client" }),
  awful.key(
    { modkey },
    "t",
    function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }
  ),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, { description = "minimize", group = "client" }),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then tag:view_only() end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then awful.tag.viewtoggle(tag) end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then client.focus:move_to_tag(tag) end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then client.focus:toggle_tag(tag) end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
  "request::titlebars",
  function(c)
    awful.titlebar(c):setup {
      {
        align = "center",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      layout = wibox.layout.flex.horizontal,
    }
  end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
  "mouse::enter",
  function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end
)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
