{ lib, inputs, config, pkgs, channels,  ... }:

{
    home.stateVersion = "25.11";
    home.homeDirectory = "/home/ki11errabbit";
    home.packages = with pkgs; [
        discord
        slack
        signal-desktop
        lutris
        gnome-boxes
        freecad
        librecad
        #kicad
        prismlauncher
        burpsuite
        blender
        arduino-ide
        kdePackages.qtmultimedia
    ];
    programs.zen-browser.enable = true;

    wayland.windowManager.mango = {
        enable = true;
        settings = builtins.readFile(../mangowc-laptop-nix/.config/mango/config.conf);
        autostart_sh = "";
    };
    

    wayland.windowManager.sway = {
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
            text = builtins.readFile(../scripts/think-nix-t480/setup-swayidle.sh);
        };
    };
    
    xdg.mimeApps = {
        enable = true;
        associations.added = {
            "application/x-extension-html" = [ "zen.desktop" ];
            "application/x-extension-htm" = [ "zen.desktop" ];
            "application/x-extension-xhtml" = [ "zen.desktop" ];
            "application/x-extension-shtml" = [ "zen.desktop" ];
            "application/x-extension-xht" = [ "zen.desktop" ];
            "application/xhtml+xml" = [ "zen.desktop" ];
            "text/html" = [ "zen.desktop" ];
            "x-scheme-handler/about" = [ "zen.desktop" ];
            "x-scheme-handler/attachment" = [ "zen.desktop" ];
            "x-scheme-handler/chrome" = [ "zen.desktop" ];
            "x-scheme-handler/http" = [ "zen.desktop" ];
            "x-scheme-handler/https" = [ "zen.desktop" ];
        };
        defaultApplications = {
            "application/x-extension-html" = [ "zen.desktop" ];
            "application/x-extension-htm" = [ "zen.desktop" ];
            "application/x-extension-xhtml" = [ "zen.desktop" ];
            "application/x-extension-shtml" = [ "zen.desktop" ];
            "application/x-extension-xht" = [ "zen.desktop" ];
            "application/xhtml+xml" = [ "zen.desktop" ];
            "text/html" = [ "zen.desktop" ];
            "x-scheme-handler/about" = [ "zen.desktop" ];
            "x-scheme-handler/attachment" = [ "zen.desktop" ];
            "x-scheme-handler/chrome" = [ "zen.desktop" ];
            "x-scheme-handler/http" = [ "zen.desktop" ];
            "x-scheme-handler/https" = [ "zen.desktop" ];

        };
    };
    home.file = {
        ".config/kmonad/t480.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "T480s Keyboard")
                cmp-seq ralt
                cmp-seq-delay 5
                fallthrough true
                allow-cmd false
            )

            (defalias 
                srch KeySearch
                vido KeySwitchVideoMode
                cfg  KeyConfig
                lnch KeyScale
                fn (layer-toggle function)

            )



            (defsrc
                esc  mute vold volu f20  brdn brup KeySwitchVideoMode wlan  KeyConfig  KeyBluetooth KeyScale file   home  end   ins   del
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt ssrq rctl pgup up   pgdn
                                                                       left down rght
            )


            (deflayer qwerty
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  KeyBluetooth @lnch file   home  end   ins   caps
                grv   1     2     3     4     5    6    7     8     9     0     -     =      del
                tab   q     w     e     r     t    y    u     i     o     p     [     ]      \
                bspc  a     s     d     f     g    h    j     k     l     ;     '     ret
                lsft  z     x     c     v     b    n    m     ,     .     /     rsft
                lctl  @fn   lalt  lmet        spc             ralt  ssrq  rctl  pgup  up    pgdn
                                                                                left  down  rght
            )


            (deflayer function
                _    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _    _     _   
                _    _    _    _    _    _    _    _    _    _    _    _    _    _
                _    _    _    _    _    _    _    _    _    _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _   
                _    _    _    _         _              _    _    _    _    _    _   
                                                                       _    _    _   
            )
        '';
        ".local/bin/setup-keyboard.sh" = {
            executable = true;
            text = ''
#!/bin/sh

sudo ${pkgs.kmonad}/bin/kmonad /home/ki11errabbit/.config/kmonad/t480.kbd
            '';
        };
    };
}

