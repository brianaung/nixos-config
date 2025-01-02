{ pkgs, config, ... }:
{
  xdg.configFile."ghostty/config".source = pkgs.writeText "config" /*sh*/ ''
    font-family = JetBrainsMono Nerd Font
    font-size = 11

    window-decoration = true
    shell-integration-features = no-cursor,no-sudo,title
    confirm-close-surface = false
    cursor-style-blink = false

    background-opacity = 1
    background = #${config.colors.Background}
    foreground = #${config.colors.Foreground}
    palette = 0=#${config.colors.Black}
    palette = 1=#${config.colors.Red}
    palette = 2=#${config.colors.Green}
    palette = 3=#${config.colors.Yellow}
    palette = 4=#${config.colors.Blue}
    palette = 5=#${config.colors.Magenta}
    palette = 6=#${config.colors.Cyan}
    palette = 7=#${config.colors.White}
    palette = 8=#${config.colors.BrightBlack}
    palette = 9=#${config.colors.BrightRed}
    palette = 10=#${config.colors.BrightGreen}
    palette = 11=#${config.colors.BrightYellow}
    palette = 12=#${config.colors.BrightBlue}
    palette = 13=#${config.colors.BrightMagenta}
    palette = 14=#${config.colors.BrightCyan}
    palette = 15=#${config.colors.BrightWhite}
  '';
}
