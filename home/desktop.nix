{ lib, inputs, config, pkgs, channels,  ... }:

{

    home.packages = with pkgs; [
        obs-studio
        godot-mono
        bemenu
        wlr-randr
        waybar
        swaybg
        mpvpaper
        transmission_4-gtk
        fnott
        imv
        wdisplays
        swaylock
        libreoffice
        kmonad
        swayidle
        wl-clipboard
        hunspell
        hunspellDicts.en_US
        sway-contrib.grimshot
        heroic
        pavucontrol
        audacious
        kdePackages.ark
        gimp
        openscad
        openscad-lsp
        qutebrowser
        swaysome
    ];

    nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
            extraPkgs = pkgs: with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
            ];
        };
    };


    wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;
        checkConfig = false;
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            startup = [
                { command = "waybar"; }
                { command = "fnott"; }
                { command = "configure-monitors.sh"; }
                { command = "setup-wallpaper.sh"; }
                { command = "setup-swayidle.sh"; }
                { command = "setup-keyboard.sh"; }
                { command = "nm-applet"; }
                { command = "blueman-applet"; }
                { command = "kdeconnect-indicator"; }
                { command = "swaysome init 1"; }
            ];
            menu = "bemenu-run";
            colors.background = "#eff1f5";
            colors.focused = {
                background = "#eff1f5";
                border = "#ea76cb";
                childBorder = "#ea76cb";
                indicator = "#ea76cb";
                text = "#4c4f69";
            };
            colors.focusedInactive = {
                background = "#eff1f5";
                border = "#9ca0b0";
                childBorder = "#9ca0b0";
                indicator = "#9ca0b0";
                text = "#4c4f69";
            };
            colors.placeholder = {
                background = "#eff1f5";
                border = "#9ca0b0";
                childBorder = "#9ca0b0";
                indicator = "#9ca0b0";
                text = "#4c4f69";
            };
            colors.unfocused = {
                background = "#eff1f5";
                border = "#9ca0b0";
                childBorder = "#9ca0b0";
                indicator = "#9ca0b0";
                text = "#4c4f69";
            };
            colors.urgent = {
                background = "#eff1f5";
                border = "#d20f39";
                childBorder = "#d20f39";
                indicator = "#d20f39";
                text = "#4c4f69";
            };
            bars = [];
            left = "m";
            down = "n";
            up = "e";
            right = "i";
            focus.followMouse = "yes";
            gaps = {
                inner = 10;
                outer = 10;
            };
            window = {
                border = 2;
            };
            keybindings = {
                "${modifier}+d" = "exec ${menu}";
                "${modifier}+r" = "exec nemo";
                "${modifier}+s" = "exec grimshot save area";
                "${modifier}+Shift+s" = "exec grimshot copy area";
                "${modifier}+Shift+Return" = "exec emacsclient -c -a 'emacs'";

                "${modifier}+q" = "kill";
                "${modifier}+Shift+q" = "exec swaymsg exit";
                "${modifier}+Shift+r" = "reload";

                "${modifier}+1" = "exec 'swaysome focus 1'";
                "${modifier}+2" = "exec 'swaysome focus 2'";
                "${modifier}+3" = "exec 'swaysome focus 3'";
                "${modifier}+4" = "exec 'swaysome focus 4'";
                "${modifier}+5" = "exec 'swaysome focus 5'";
                "${modifier}+6" = "exec 'swaysome focus 6'";
                "${modifier}+7" = "exec 'swaysome focus 7'";
                "${modifier}+8" = "exec 'swaysome focus 8'";
                "${modifier}+9" = "exec 'swaysome focus 9'";
                "${modifier}+0" = "exec 'swaysome focus 0'";

                "${modifier}+Shift+1" = "exec 'swaysome move 1'";
                "${modifier}+Shift+2" = "exec 'swaysome move 2'";
                "${modifier}+Shift+3" = "exec 'swaysome move 3'";
                "${modifier}+Shift+4" = "exec 'swaysome move 4'";
                "${modifier}+Shift+5" = "exec 'swaysome move 5'";
                "${modifier}+Shift+6" = "exec 'swaysome move 6'";
                "${modifier}+Shift+7" = "exec 'swaysome move 7'";
                "${modifier}+Shift+8" = "exec 'swaysome move 8'";
                "${modifier}+Shift+9" = "exec 'swaysome move 9'";
                "${modifier}+Shift+0" = "exec 'swaysome move 0'";

                "${modifier}+Shift+comma" = "exec 'swaysome prev-output'";
                "${modifier}+Shift+period" = "exec 'swaysome next-output'";

                "${modifier}+${left}" = "focus left";
                "${modifier}+${down}" = "focus down";
                "${modifier}+${up}" = "focus up";
                "${modifier}+${right}" = "focus right";
                
                "${modifier}+Shift+${left}" = "move left";
                "${modifier}+Shift+${down}" = "move down";
                "${modifier}+Shift+${up}" = "move up";
                "${modifier}+Shift+${right}" = "move right";

                "${modifier}+Ctrl+${left}" = "resize set width -10pt";
                "${modifier}+Ctrl+${down}" = "resize set width 10pt";
                "${modifier}+Ctrl+${up}" = "resize set height 10pt";
                "${modifier}+Ctrl+${right}" = "resize set height -10pt";

                "${modifier}+v" = "splitv";
                "${modifier}+h" = "splith";

                "${modifier}+f" = "fullscreen toggle";
                
                "${modifier}+a" = "layout stacking";
                "${modifier}+t" = "layout tabbed";
                "${modifier}+p" = "layout toggle split";

                "${modifier}+Shift+space" = "floating toggle";
                "${modifier}+space" = "focus mode_toggle";

                "${modifier}+Shift+minus" = "move scratchpad";
                "${modifier}+minus" = "scratchpad show";

                "XF86AudioRaiseVolume" = "exec 'pamixer -i 3'";
                "XF86AudioLowerVolume" = "exec 'pamixer -d 3'";
                "XF86AudioMute" = "exec 'pamixer --toggle-mute'";
            };
        };
        extraConfig = ''
        '';

    };

    programs.foot = {
        enable = true;
        #enableZshIntegration = true;
        settings = {
            main = {
                font = "JetbrainsMonoNerdFont:size=11";
            };
            colors = {
                cursor="eff1f5 dc8a78";
                foreground="4c4f69";
                background="eff1f5";

                regular0="5c5f77";
                regular1="d20f39";
                regular2="40a02b";
                regular3="df8e1d";
                regular4="1e66f5";
                regular5="ea76cb";
                regular6="179299";
                regular7="acb0be";

                bright0="6c6f85";
                bright1="d20f39";
                bright2="40a02b";
                bright3="df8e1d";
                bright4="1e66f5";
                bright5="ea76cb";
                bright6="179299";
                bright7="bcc0cc";

                "16"="fe640b";
                "17"="dc8a78";

                selection-foreground="4c4f69";
                selection-background="ccced7";

                search-box-no-match="dce0e8 d20f39";
                search-box-match="4c4f69 ccd0da";

                jump-labels="dce0e8 fe640b";
                urls="1e66f5";
            };
        };
    };

    home.file = {
        ".local/bin/run-wallpaper-wayland.sh" = {
            executable = true;
            text = builtins.readFile(../scripts/run-wallpaper-wayland.sh);
        };
    };

    xdg.desktopEntries = {
        run-java-jar = {
            name = "Run Java Jar";
            genericName = "Java Jar";
            exec = "java -jar %F";
            icon = "java";
            mimeType = [ "application/x-java-archive" ];
            categories = [ "Development" "Java" ];
            comment = "Run a Java JAR file";
            terminal = false;
        };
        emacsclient = {
            name = "Emacs Client";
            genericName = "Emacs Client";
            exec = "emacsclient -c -a \"emacs\" %F";
            icon = "emacs";
            categories = [ "Development" "TextEditor" "Utility" ];
            comment = "Edit text files with Emacs";
            terminal = false;
        };
        emacsdaemon = {
            name = "Emacs Daemon";
            genericName = "Emacs Daemon";
            exec = "emacs --daemon";
            icon = "emacs";
            categories = [ "Development" "TextEditor" "Utility" ];
            comment = "Start an Emacs daemon";
            terminal = false;
        };
        run-wayland-wallpapers = {
            name = "Run Wayland Wallpapers";
            genericName = "Wayland Wallpapers";
            exec = "run-wallpaper-wayland.sh 300";
            icon = "wayland";
            mimeType = [];
            categories = [];
            comment = "Runs the run-wallpaper-wayland.sh script";
            terminal = false;
        };
    };

    xdg.mimeApps = {
        enable = true;
        associations.added = {
            "application/pdf" = [ "okularApplication_pdf.desktop" ];
            "application/xml" = [ "emacsclient.desktop" ];
            "application/x-shellscript" = [ "emacsclient.desktop" ];
            "text/x-shellscript" = [ "emacsclient.desktop" ];
            "application/x-extension-txt" = [ "emacsclient.desktop" ];
            "text/plain" = [ "emacsclient.desktop" ];
            "application/x-extension-md" = [ "emacsclient.desktop" ];
            "application/x-extension-markdown" = [ "emacsclient.desktop" ];
            "application/x-extension-c" = [ "emacsclient.desktop" ];
            "application/x-extension-clj" = [ "emacsclient.desktop" ];
            "application/x-extension-cljc" = [ "emacsclient.desktop" ];
            "application/x-extension-cljscm" = [ "emacsclient.desktop" ];
            "application/x-extension-cljs" = [ "emacsclient.desktop" ];
            "application/x-extension-cpp" = [ "emacsclient.desktop" ];
            "text/english" = [ "emacsclient.desktop" ];
            "text/rust" = [ "emacsclient.desktop" ];
            "text/xml" = [ "emacsclient.desktop" ];
            "text/x-c" = [ "emacsclient.desktop" ];
            "text/x-csrc" = [ "emacsclient.desktop" ];
            "text/x-c++src" = [ "emacsclient.desktop" ];
            "text/x-emacs-lisp" = [ "emacsclient.desktop" ];
            "text/x-patch" = [ "emacsclient.desktop" ];
            "text/x-java" = [ "emacsclient.desktop" ];
            "text/x-log" = [ "emacsclient.desktop" ];
            "text/x-lua" = [ "emacsclient.desktop" ];
            "text/x-python" = [ "emacsclient.desktop" ];
            "text/x-makefile" = [ "emacsclient.desktop" ];
            "text/x-pascal" = [ "emacsclient.desktop" ];
            "text/x-chdr" = [ "emacsclient.desktop" ];
            "text/csv" = [ "libreoffice-calc.desktop" ];
            "text/x-tex" = [ "emacsclient.desktop" ];
            "text/x-c++" = [ "emacsclient.desktop" ];
            "text/x-c++hdr" = [ "emacsclient.desktop" ];
            "application/x-extension-tex" = [ "emacsclient.desktop" ];
            "application/x-extension-texinfo" = [ "emacsclient.desktop" ];
            "application/x-extension-texi" = [ "emacsclient.desktop" ];
            "application/x-extension-epub" = [ "okularApplication_epub.desktop" ];
            "audio/flac" = [ "audacious.desktop" ];
            "audio/x-flac" = [ "audacious.desktop" ];
            "audio/mpeg" = [ "audacious.desktop" ];
            "audio/x-m4a" = [ "audacious.desktop" ];
            "audio/x-wav" = [ "audacious.desktop" ];
            "audio/x-opus" = [ "audacious.desktop" ];
            "audio/ogg" = [ "audacious.desktop" ];
            "audio/x-vorbis+ogg" = [ "audacious.desktop" ];
            "audio/x-musepack" = [ "audacious.desktop" ];
            "video/mp4" = [ "mpv.desktop" ];
            "video/x-matroska" = [ "mpv.desktop" ];
            "video/x-matroska-3d" = [ "mpv.desktop" ];
            "video/webm" = [ "mpv.desktop" ];
            "video/avi" = [ "mpv.desktop" ];
            "video/x-flv" = [ "mpv.desktop" ];
            "video/quicktime" = [ "mpv.desktop" ];
            "inode/directory" = [ "com.system76.CosmicFiles.desktop" ];
            "x-scheme-handler/terminal" = [ "com.system76.CosmicTerm.desktop" ];
            "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
            "x-scheme-handler/msteams" = [ "teams-for-linux.desktop" ];
            "x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
            "x-scheme-handler/sgnl" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/signalcaptcha" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/slack" = [ "slack.desktop" ];
            "application/zip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-java-archive" = [ "run-java-jar.desktop" "org.gnome.FileRoller.desktop" ];
            "application/x-bittorrent" = [ "transmission-qt.desktop" ];
            "application/x-ms-dos-executable" = [ "wine.desktop" ];
            "application/x-msi" = [ "wine.desktop" ];
            "application/x-ms-shortcut" = [ "wine.desktop" ];
            "application/x-ms-wim" = [ "wine.desktop" ];
            "application/x-cd-image" = [ "org.gnome.FileRoller.desktop" ];
            "x-scheme-handler/steam" = [ "steam.desktop" ];
            "x-scheme-handler/itchio" = [ "itch.desktop" ];
            "x-scheme-handler/tel" = [ "org.kde.kdeconnect.handler.desktop" ];
            "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-xz" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzma" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-krita" = [ "krita_kra.desktop" ];
        };
        defaultApplications = {
            "x-scheme-handler/terminal" = [ "com.system76.CosmicTerm.desktop" ];
            "application/x-terminal-emulator" = [ "com.system76.CosmicTerm.desktop" ];
            "application/pdf" = [ "okularApplication_pdf.desktop" ];
            "application/xml" = [ "emacsclient.desktop" ];
            "application/x-shellscript" = [ "emacsclient.desktop" ];
            "text/x-shellscript" = [ "emacsclient.desktop" ];
            "application/x-extension-txt" = [ "emacsclient.desktop" ];
            "text/plain" = [ "emacsclient.desktop" ];
            "application/x-extension-md" = [ "emacsclient.desktop" ];
            "application/x-extension-markdown" = [ "emacsclient.desktop" ];
            "application/x-extension-c" = [ "emacsclient.desktop" ];
            "application/x-extension-clj" = [ "emacsclient.desktop" ];
            "application/x-extension-cljc" = [ "emacsclient.desktop" ];
            "application/x-extension-cljscm" = [ "emacsclient.desktop" ];
            "application/x-extension-cljs" = [ "emacsclient.desktop" ];
            "application/x-extension-cpp" = [ "emacsclient.desktop" ];
            "text/english" = [ "emacsclient.desktop" ];
            "text/rust" = [ "emacsclient.desktop" ];
            "text/xml" = [ "emacsclient.desktop" ];
            "text/x-c" = [ "emacsclient.desktop" ];
            "text/x-csrc" = [ "emacsclient.desktop" ];
            "text/x-c++src" = [ "emacsclient.desktop" ];
            "text/x-emacs-lisp" = [ "emacsclient.desktop" ];
            "text/x-patch" = [ "emacsclient.desktop" ];
            "text/x-java" = [ "emacsclient.desktop" ];
            "text/x-log" = [ "emacsclient.desktop" ];
            "text/x-lua" = [ "emacsclient.desktop" ];
            "text/x-python" = [ "emacsclient.desktop" ];
            "text/x-makefile" = [ "emacsclient.desktop" ];
            "text/x-pascal" = [ "emacsclient.desktop" ];
            "text/x-chdr" = [ "emacsclient.desktop" ];
            "text/csv" = [ "libreoffice-calc.desktop" ];
            "text/x-tex" = [ "emacsclient.desktop" ];
            "text/x-c++" = [ "emacsclient.desktop" ];
            "text/x-c++hdr" = [ "emacsclient.desktop" ];
            "application/x-extension-tex" = [ "emacsclient.desktop" ];
            "application/x-extension-texinfo" = [ "emacsclient.desktop" ];
            "application/x-extension-texi" = [ "emacsclient.desktop" ];
            "application/x-extension-epub" = [ "okularApplication_epub.desktop" ];
            "audio/flac" = [ "audacious.desktop" ];
            "audio/x-flac" = [ "audacious.desktop" ];
            "audio/mpeg" = [ "audacious.desktop" ];
            "audio/x-m4a" = [ "audacious.desktop" ];
            "audio/x-wav" = [ "audacious.desktop" ];
            "audio/x-opus" = [ "audacious.desktop" ];
            "audio/ogg" = [ "audacious.desktop" ];
            "audio/x-vorbis+ogg" = [ "audacious.desktop" ];
            "audio/x-musepack" = [ "audacious.desktop" ];
            "video/mp4" = [ "mpv.desktop" ];
            "video/x-matroska" = [ "mpv.desktop" ];
            "video/x-matroska-3d" = [ "mpv.desktop" ];
            "video/webm" = [ "mpv.desktop" ];
            "video/avi" = [ "mpv.desktop" ];
            "video/x-flv" = [ "mpv.desktop" ];
            "video/quicktime" = [ "mpv.desktop" ];
            "inode/directory" = [ "com.system76.CosmicFiles.desktop" ];
            "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
            "x-scheme-handler/msteams" = [ "teams-for-linux.desktop" ];
            "x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
            "x-scheme-handler/sgnl" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/signalcaptcha" = [ "signal-desktop.desktop" ];
            "x-scheme-handler/slack" = [ "slack.desktop" ];
            "application/zip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-java-archive" = [ "run-java-jar.desktop" "org.gnome.FileRoller.desktop" ];
            "application/x-bittorrent" = [ "transmission-qt.desktop" ];
            "application/x-ms-dos-executable" = [ "wine.desktop" ];
            "application/x-msi" = [ "wine.desktop" ];
            "application/x-ms-shortcut" = [ "wine.desktop" ];
            "application/x-ms-wim" = [ "wine.desktop" ];
            "application/x-cd-image" = [ "org.gnome.FileRoller.desktop" ];
            "x-scheme-handler/steam" = [ "steam.desktop" ];
            "x-scheme-handler/itchio" = [ "itch.desktop" ];
            "x-scheme-handler/tel" = [ "org.kde.kdeconnect.handler.desktop" ];
            "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-xz" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-bzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzma" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lzip" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-lz4-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
            "application/x-krita" = [ "krita_kra.desktop" ];

        };
    };
}

