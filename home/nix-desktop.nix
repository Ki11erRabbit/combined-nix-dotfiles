{ lib, inputs, config, pkgs, channels,  ... }:

{
    home.stateVersion = "25.11";
    home.homeDirectory = "/home/ki11errabbit";
    home.packages = with pkgs; [
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
        kdePackages.qtmultimedia
    ];
    programs.zen-browser.enable = true;

    wayland.windowManager.mango = {
        enable = true;
        #extraConfig = (builtins.readFile(../mangowc-desktop-nix/.config/mango/config.conf).text);
        extraConfig = ''
        '';
        settings = {
            enable_hotarea = 0;

            tap_to_click = 0;
            tap_and_drag = 0;
            trackpad_natural_scrolling = 1;

            shadows = 1;
            layer_shadows = 1;

            gappoh = 5;
            gappov = 10;
            borderpx = 2;

            rootcolor = "0xeff1f5ff";
            bordercolor = "0x9ca0b0ff";
            focuscolor = "0xea76cbff";
            urgentcolor = "0xd20f39ff";
            scratchpadcolor = "0x9ca0b0ff";
            globalcolor = "0x9ca0b0ff";
            #coverlayercolor = "0x9ca0b0ff";

            windowrule = [ "isterm:1,appid:Alacritty" ];

            monitorrule = [
                "name:DP-1,x:1080,y:300,width:2560,height:1440,refresh:120,vrr:1"
                "name:DP-2,x:3640,y:577,width:1920,height:1080,refresh:60"
                "name:HDMI-A-1,x:0,y:0,rr:3,width:1920,height:1080,refresh:60"
            ];

            bind = [
                "SUPER,q,killclient"
                "SUPER,Return,spawn,alacritty"
# d
                "SUPER,d,spawn,noctalia-shell ipc call launcher toggle"
# r
                "SUPER,r,spawn,dolphin"
# s
                "SUPER,s,spawn,grimshot save area"
                "SUPER+SHIFT,s,spawn,grimshot copy area"
                "SUPER+SHIFT,Return,spawn,emacsclient -c -a 'emacs'"
# n
                "SUPER,n,focusstack,next"
# e
                "SUPER,e,focusstack,prev"
# n
                "SUPER+SHIFT,n,exchange_client,down"
# e
                "SUPER+SHIFT,e,exchange_client,up"
# m
                "SUPER+SHIFT,m,exchange_client,left"
# i
                "SUPER+SHIFT,i,exchange_client,right"
# n
                "SUPER+CTRL,n,focusdir,down"
# e
                "SUPER+CTRL,e,focusdir,up"
# m
                "SUPER+CTRL,m,focusdir,left"
# i
                "SUPER+CTRL,i,focusdir,right"
                "SUPER+CTRL,Return,zoom"

# u
                "SUPER,u,viewtoright"
# l
                "SUPER,l,viewtoleft"

                "SUPER,1,view,1"
                "SUPER,2,view,2"
                "SUPER,3,view,3"
                "SUPER,4,view,4"
                "SUPER,5,view,5"
                "SUPER,6,view,6"
                "SUPER,7,view,7"
                "SUPER,8,view,8"
                "SUPER,9,view,9"

                "SUPER+SHIFT,1,tag,1"
                "SUPER+SHIFT,2,tag,2"
                "SUPER+SHIFT,3,tag,3"
                "SUPER+SHIFT,4,tag,4"
                "SUPER+SHIFT,5,tag,5"
                "SUPER+SHIFT,6,tag,6"
                "SUPER+SHIFT,7,tag,7"
                "SUPER+SHIFT,8,tag,8"
                "SUPER+SHIFT,9,tag,9"

                "SUPER,comma,focusmon,left"
                "SUPER,period,focusmon,right"
                "SUPER+SHIFT,code:59,tagmon,left"
                "SUPER+SHIFT,code:60,tagmon,right"

# f
                "SUPER,f,togglefullscreen"
# m
                "SUPER+ALT,m,incnmaster,+1"
# i
                "SUPER+ALT,i,incnmaster,-1"
                "SUPER+SHIFT,q,quit"
# r
                #"SUPER+CTRL,r,reload"

# t
                "SUPER,t,setlayout,tile"
# c
                "SUPER,c,setlayout,scroller"
# t
                "SUPER+ALT,t,setlayout,vertical_tile"
# c
"SUPER+ALT,c,setlayout,vertical_scroller"

                "NONE,code:123,spawn,noctalia-shell ipc call volume increase"
                "NONE,code:122,spawn,noctalia-shell ipc call volume decrease"
                "NONE,code:121,spawn,noctalia-shell ipc call volume muteOutput"

                "NONE,code:232,spawn,noctalia-shell ipc call brightness increase"
                "NONE,code:233,spawn,noctalia-shell ipc call brightness decrease"


#bindsym XF86_AudioMicMute exec 'noctalia-shell ipc call volume muteInput'

#bindsym XF86Sleep exec 'noctalia-shell ipc call sessionMenu lockAndSuspend'
                "NONE,code:172,spawn,noctalia-shell ipc call media playPause"
                "NONE,code:173,spawn,noctalia-shell ipc call media previous"
                "NONE,code:171,spawn,noctalia-shell ipc call media next"
                "NONE,code:225,spawn,noctalia-shell ipc call launcher toggle"

                "NONE,code:128,toggleoverview"
            ];

            mousebind = [
                "SUPER,btn_left,moveresize,curmove"
                "SUPER,btn_right,moveresize,curresize"
            ];

            gesturebind = [
                "none,left,3,viewtoright"
                "none,right,3,viewtoleft"
                "none,up,3,toggleoverview"
                "none,down,3,toggleoverview"

                "none,left,4,focusmon,left"
                "none,right,4,focusmon,right"
            ];

            env = [
                "QT_QA_PLATFORM,qt6ct"
                "XDG_CURRENT_DESKTOP,mango"
            ];
        };
        autostart_sh = ''
quickshell -n -c /home/ki11errabbit/.config/quickshell/getting-ready/ &
noctalia-shell &
/home/ki11errabbit/.local/bin/configure-monitors.sh &
/home/ki11errabbit/.local/bin/setup-wallpaper.sh &
/home/ki11errabbit/.local/bin/setup-swayidle.sh &
/home/ki11errabbit/.local/bin/setup-keyboard.sh &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango &
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
        '';
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
            text = builtins.readFile(../scripts/desktop/setup-swayidle.sh);
        };
        ".local/bin/setup-keyboard.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/setup-keyboard.sh);
        };
        ".local/bin/setup-wallpaper.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/setup-wallpaper.sh);
        };
        ".local/bin/configure-monitor.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/configure-monitors.sh);
        };
        ".local/bin/screen-toggle.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/screen-toggle.sh);
        };
        ".local/bin/wallpaper-wayland.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/wallpaper-wayland.sh);
        };
        ".local/bin/lockscreen.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/desktop/lockscreen.sh);
        };
        ".config/fnott/fnott.ini" = {
            text = builtins.readFile(../fnott-desktop/.config/fnott/fnott.ini);
        };
        ".config/waybar/config" = {
            text = builtins.readFile(../waybar-desktop/.config/waybar/config);
        };
    };
    
    xdg.mimeApps = {
        enable = true;
        associations.added = {
            "application/x-extension-html" = [ "zen-beta.desktop" ];
            "application/x-extension-htm" = [ "zen-beta.desktop" ];
            "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
            "application/x-extension-shtml" = [ "zen-beta.desktop" ];
            "application/x-extension-xht" = [ "zen-beta.desktop" ];
            "application/xhtml+xml" = [ "zen-beta.desktop" ];
            "text/html" = [ "zen-beta.desktop" ];
            "x-scheme-handler/about" = [ "zen-beta.desktop" ];
            "x-scheme-handler/attachment" = [ "zen-beta.desktop" ];
            "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
            "x-scheme-handler/http" = [ "zen-beta.desktop" ];
            "x-scheme-handler/https" = [ "zen-beta.desktop" ];
        };
        defaultApplications = {
            "application/x-extension-html" = [ "zen-beta.desktop" ];
            "application/x-extension-htm" = [ "zen-beta.desktop" ];
            "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
            "application/x-extension-shtml" = [ "zen-beta.desktop" ];
            "application/x-extension-xht" = [ "zen-beta.desktop" ];
            "application/xhtml+xml" = [ "zen-beta.desktop" ];
            "text/html" = [ "zen-beta.desktop" ];
            "x-scheme-handler/about" = [ "zen-beta.desktop" ];
            "x-scheme-handler/attachment" = [ "zen-beta.desktop" ];
            "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
            "x-scheme-handler/http" = [ "zen-beta.desktop" ];
            "x-scheme-handler/https" = [ "zen-beta.desktop" ];

        };
    };
}

