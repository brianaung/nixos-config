{ pkgs, config, ... }:
{
  xdg.configFile."awesome/rc.lua".source = pkgs.writers.writeLua "rc.lua" { } /*lua*/ ''
    -- luacheck: push ignore
    pcall(require, "luarocks.loader")

    local awesome = awesome
    local client = client
    local root = root

    -- @DOC_REQUIRE_SECTION@
    local awful = require "awful"
    local beautiful = require "beautiful"
    local gears = require "gears"
    local hotkeys_popup = require "awful.hotkeys_popup"
    local menubar = require "menubar"
    local naughty = require "naughty"
    local wibox = require "wibox"
    require "awful.hotkeys_popup.keys"
    require "awful.autofocus"

    -- {{{ Error handling
    -- @DOC_ERROR_HANDLING@
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

    -- {{{ Variable definitions
    -- @DOC_LOAD_THEME@
    beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

    -- @DOC_DEFAULT_APPLICATIONS@
    -- This is used later as the default terminal and editor to run.
    local terminal = "ghostty"
    local editor = os.getenv "EDITOR" or "nvim"
    local editor_cmd = terminal .. " -e " .. editor

    local modkey = "Mod4"

    -- @DOC_LAYOUT@
    awful.layout.layouts = {
      awful.layout.suit.tile,
      awful.layout.suit.floating,
    }
    -- }}}

    -- {{{ Wallpaper
    local function set_wallpaper(s)
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end
    -- reset wallpaper when screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)
    -- }}}

    -- {{{ Menu
    -- @DOC_MENU@
    local mymainmenu = awful.menu {
      items = {
        {
          "hotkeys",
          function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
        },
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        {
          "quit",
          function() awesome.quit() end,
        },
        { "open terminal", terminal },
      },
    }

    -- Menubar configuration
    menubar.utils.terminal = terminal -- Set the terminal for applications that require it
    -- }}}

    -- {{{ Wibar
    -- Battery Widget
    local battery_widget = wibox.widget.textbox()
    gears.timer {
      timeout = 10,
      call_now = true,
      autostart = true,
      callback = function()
        awful.spawn.easy_async_with_shell("acpi -b", function(stdout)
          local status, percentage = string.match(stdout, "Battery %d+: (.*), (%d+%%)")
          -- Update text based on charging status
          if status and status:find "Charging" then
            battery_widget.text = "CHR(" .. percentage .. ")"
          else
            battery_widget.text = "BAT(" .. percentage .. ")"
          end
        end)
      end,
    }

    local volume_widget = wibox.widget.textbox()
    local retry = 0
    local function update_volume_widget()
      awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
        if (not stdout or stdout == "") and retry < 5 then
          retry = retry + 1
          update_volume_widget()
        end

        local volume, muted = string.match(stdout, "Volume: (%d+%.%d+) %[(%w+)%]") -- For Muted case
        if not muted then
          volume = string.match(stdout, "Volume: (%d+%.%d+)") -- For Unmuted case
        end

        if volume then
          local volume_percentage = volume * 100
          volume_widget.text = muted and "MUT(" .. volume_percentage .. "%)" or "VOL(" .. volume_percentage .. "%)"
        end
      end)
    end
    update_volume_widget()
    -- Listen for volume change events
    awesome.connect_signal("volume::changed", function() update_volume_widget() end)

    -- Create a wibox for each screen and add it
    -- @DOC_FOR_EACH_SCREEN@
    awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      -- Each screen has its own tag table.
      awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

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

      -- @DOC_WIBAR@
      s.mywibox = awful.wibar { position = "top", screen = s }
      s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          awful.widget.launcher { image = beautiful.awesome_icon, menu = mymainmenu },
          s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          wibox.widget.textbox " ",
          volume_widget,
          wibox.widget.textbox " ",
          battery_widget,
          wibox.widget.textclock(),
          wibox.widget.systray(),
          s.mylayoutbox,
        },
      }
    end)
    -- }}}

    -- {{{ Mouse bindings
    -- @DOC_ROOT_BUTTONS@
    root.buttons(
      gears.table.join(
        awful.button({}, 3, function() mymainmenu:toggle() end),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
      )
    )
    -- }}}

    -- {{{ Key bindings
    -- @DOC_GLOBAL_KEYBINDINGS@
    local globalkeys = gears.table.join(
      awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
      -- awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
      -- awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
      -- awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

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
      awful.key({ modkey }, "w", function() mymainmenu:show() end, { description = "show main menu", group = "awesome" }),

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
      -- awful.key({ modkey, "Control" }, "j", function()
      --     awful.screen.focus_relative(1)
      -- end, { description = "focus the next screen", group = "screen" }),
      -- awful.key({ modkey, "Control" }, "k", function()
      --     awful.screen.focus_relative(-1)
      -- end, { description = "focus the previous screen", group = "screen" }),
      awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
      -- awful.key({ modkey }, "Tab", function()
      --     awful.client.focus.history.previous()
      --     if client.focus then
      --         client.focus:raise()
      --     end
      -- end, { description = "go back", group = "client" }),

      -- Standard program
      awful.key(
        { modkey, "Shift" },
        "Return",
        function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }
      ),
      awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
      awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),

      -- media controls
      awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        awesome.emit_signal "volume::changed"
      end, { description = "increase volume", group = "launcher" }),
      awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        awesome.emit_signal "volume::changed"
      end, { description = "decrease volume", group = "launcher" }),
      awful.key({}, "XF86AudioMute", function()
        awful.spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        awesome.emit_signal "volume::changed"
      end, { description = "mute volume", group = "launcher" }),

      -- brightness controls
      awful.key(
        {},
        "XF86MonBrightnessUp",
        function() awful.spawn "brightnessctl set 5%+" end,
        { description = "increase brightness", group = "launcher" }
      ),
      awful.key(
        {},
        "XF86MonBrightnessDown",
        function() awful.spawn "brightnessctl set 5%-" end,
        { description = "decrease brightness", group = "launcher" }
      ),

      awful.key(
        {},
        "Print",
        function() awful.spawn "flameshot gui" end,
        { description = "open screenshot tool", group = "launcher" }
      ),

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
      -- awful.key({ modkey, "Shift" }, "h", function()
      --     awful.tag.incnmaster(1, nil, true)
      -- end, { description = "increase the number of master clients", group = "layout" }),
      -- awful.key({ modkey, "Shift" }, "l", function()
      --     awful.tag.incnmaster(-1, nil, true)
      -- end, { description = "decrease the number of master clients", group = "layout" }),
      -- awful.key({ modkey, "Control" }, "h", function()
      --     awful.tag.incncol(1, nil, true)
      -- end, { description = "increase the number of columns", group = "layout" }),
      -- awful.key({ modkey, "Control" }, "l", function()
      --     awful.tag.incncol(-1, nil, true)
      -- end, { description = "decrease the number of columns", group = "layout" }),
      awful.key({ modkey }, "space", function() awful.layout.inc(1) end, { description = "select next", group = "layout" }),
      awful.key(
        { modkey, "Shift" },
        "space",
        function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }
      ),

      awful.key({ modkey, "Shift" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then c:emit_signal("request::activate", "key.unminimize", { raise = true }) end
      end, { description = "restore minimized", group = "client" }),

      awful.key({ modkey }, "p", function() menubar.show() end, { description = "show the menubar", group = "launcher" })
    )

    -- @DOC_CLIENT_KEYBINDINGS@
    local clientkeys = gears.table.join(
      awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end, { description = "toggle fullscreen", group = "client" }),
      awful.key({ modkey }, "q", function(c) c:kill() end, { description = "close", group = "client" }),
      -- awful.key(
      --     { modkey, "Control" },
      --     "space",
      --     awful.client.floating.toggle,
      --     { description = "toggle floating", group = "client" }
      -- ),
      awful.key(
        { modkey },
        "Return",
        function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }
      ),
      -- awful.key({ modkey }, "o", function(c)
      -- 	c:move_to_screen()
      -- end, { description = "move to screen", group = "client" }),
      -- awful.key({ modkey }, "t", function(c)
      -- 	c.ontop = not c.ontop
      -- end, { description = "toggle keep on top", group = "client" }),
      awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end, { description = "minimize", group = "client" }),
      awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
      end, { description = "(un)maximize", group = "client" })
      -- awful.key({ modkey, "Control" }, "m", function(c)
      --     c.maximized_vertical = not c.maximized_vertical
      --     c:raise()
      -- end, { description = "(un)maximize vertically", group = "client" }),
      -- awful.key({ modkey, "Shift" }, "m", function(c)
      --     c.maximized_horizontal = not c.maximized_horizontal
      --     c:raise()
      -- end, { description = "(un)maximize horizontally", group = "client" })
    )

    -- @DOC_NUMBER_KEYBINDINGS@
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
        end, {
          description = "toggle focused client on tag #" .. i,
          group = "tag",
        })
      )
    end

    -- @DOC_CLIENT_BUTTONS@
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
    -- @DOC_RULES@
    awful.rules.rules = {
      -- @DOC_GLOBAL_RULE@
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

      -- @DOC_FLOATING_RULE@
      -- Floating clients.
      {
        rule_any = {
          instance = {
            "DTA", -- Firefox addon DownThemAll.
            "copyq", -- Includes session name in class.
            "pinentry",
          },
          class = {
            "Arandr",
            "Blueman-manager",
            "Gpick",
            "Kruler",
            "MessageWin", -- kalarm.
            "Sxiv",
            "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            "Wpa_gui",
            "veromix",
            "xtightvncviewer",
          },

          -- Note that the name property shown in xprop might be set slightly after creation of the client
          -- and the name shown there might not match defined rules here.
          name = {
            "Event Tester", -- xev.
          },
          role = {
            "AlarmWindow", -- Thunderbird's calendar.
            "ConfigManager", -- Thunderbird's about:config.
            "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
          },
        },
        properties = { floating = true },
      },

      -- Set Firefox to always map on the tag named "2" on screen 1.
      -- { rule = { class = "Firefox" },
      --   properties = { screen = 1, tag = "2" } },
    }
    -- }}}

    -- {{{ Signals
    -- Signal function to execute when a new client appears.
    -- @DOC_MANAGE_HOOK@
    client.connect_signal("manage", function(c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- if not awesome.startup then awful.client.setslave(c) end

      if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
      end
    end)

    -- Focus follows mouse
    client.connect_signal(
      "mouse::enter",
      function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end
    )

    -- @DOC_BORDER@
    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
    -- }}}
    -- luacheck: pop
  '';
}
