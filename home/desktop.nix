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

