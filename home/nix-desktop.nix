{ lib, inputs, config, pkgs, channels,  ... }:

{
    home.stateVersion = "25.11";
    home.homeDirectory = "/home/ki11errabbit";
    home.packages = with pkgs; [
        zen
        discord
        slack
        signal-desktop
        zoom-us
        pcsx2
        rpcs3
        lutris
        gnome-boxes
        freecad
        librecad
        #kicad
        r2modman
        prismlauncher
        burpsuite
        blender
        arduino-ide
    ];

    wayland.windowManager.mango = {
        enable = true;
        settings = builtins.readFile(../mangowc-desktop/.config/mango/config.conf);
        autostart_sh = "";
    };
    

    wayland.windowManager.sway = {
        config.
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            keybindings = {
                "${modifier}+Return" = "exec ${terminal}";
            };
            workspaceOutputAssign = [
                { workspace = "1"; output = "DP-1"; }
                { workspace = "2"; output = "DP-1"; }
                { workspace = "3"; output = "DP-1"; }
                { workspace = "4"; output = "DP-1"; }
                { workspace = "5"; output = "DP-1"; }
                { workspace = "6"; output = "DP-1"; }
                { workspace = "7"; output = "DP-1"; }
                { workspace = "8"; output = "DP-1"; }
                { workspace = "9"; output = "DP-1"; }
                { workspace = "10"; output = "DP-1"; }
                { workspace = "11"; output = "DP-2"; }
                { workspace = "12"; output = "DP-2"; }
                { workspace = "13"; output = "DP-2"; }
                { workspace = "14"; output = "DP-2"; }
                { workspace = "15"; output = "DP-2"; }
                { workspace = "16"; output = "DP-2"; }
                { workspace = "17"; output = "DP-2"; }
                { workspace = "18"; output = "DP-2"; }
                { workspace = "19"; output = "DP-2"; }
                { workspace = "20"; output = "DP-2"; }
                { workspace = "21"; output = "HDMI-A-1"; }
                { workspace = "22"; output = "HDMI-A-1"; }
                { workspace = "23"; output = "HDMI-A-1"; }
                { workspace = "24"; output = "HDMI-A-1"; }
                { workspace = "25"; output = "HDMI-A-1"; }
                { workspace = "26"; output = "HDMI-A-1"; }
                { workspace = "27"; output = "HDMI-A-1"; }
                { workspace = "28"; output = "HDMI-A-1"; }
                { workspace = "29"; output = "HDMI-A-1"; }
                { workspace = "30"; output = "HDMI-A-1"; }
            ];
        };
        extraConfig = ''
        '';

    };

    home.file = {
        ".local/bin/setup-swayidle.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/setup-swayidle.sh)
        };
        ".local/bin/setup-keyboard.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/setup-keyboard.sh)
        };
        ".local/bin/setup-wallpaper.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/setup-wallpaper.sh)
        };
        ".local/bin/configure-monitor.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/configure-monitors.sh)
        };
        ".local/bin/screen-toggle.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/screen-toggle.sh)
        };
        ".local/bin/wallpaper-wayland.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/wallpaper-wayland.sh)
        };
        ".local/bin/lockscreen.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/lockscreen.sh)
        };
        ".config/fnott/fnott.ini" = {
            text = builtins.readFile(../fnott-desktop/.config/fnott/fnott.ini)
        };
        ".config/waybar/config" = {
            text = builtins.readFile(../waybar-desktop/.config/waybar/config)
        };
    };
    
    xdg.mimeApps = {
        enable = true;
        associations.added = {
            "application/x-extension-html" = [ "firefox.desktop" ];
            "application/x-extension-htm" = [ "firefox.desktop" ];
            "application/x-extension-xhtml" = [ "firefox.desktop" ];
            "application/x-extension-shtml" = [ "firefox.desktop" ];
            "application/x-extension-xht" = [ "firefox.desktop" ];
            "application/xhtml+xml" = [ "firefox.desktop" ];
            "text/html" = [ "firefox.desktop" ];
            "x-scheme-handler/about" = [ "firefox.desktop" ];
            "x-scheme-handler/attachment" = [ "firefox.desktop" ];
            "x-scheme-handler/chrome" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];
        };
        defaultApplications = {
            "application/x-extension-html" = [ "firefox.desktop" ];
            "application/x-extension-htm" = [ "firefox.desktop" ];
            "application/x-extension-xhtml" = [ "firefox.desktop" ];
            "application/x-extension-shtml" = [ "firefox.desktop" ];
            "application/x-extension-xht" = [ "firefox.desktop" ];
            "application/xhtml+xml" = [ "firefox.desktop" ];
            "text/html" = [ "firefox.desktop" ];
            "x-scheme-handler/about" = [ "firefox.desktop" ];
            "x-scheme-handler/attachment" = [ "firefox.desktop" ];
            "x-scheme-handler/chrome" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];

        };
    };
}

