{ lib, inputs, config, pkgs, channels,  ... }:

{
    home.stateVersion = "25.11";
    home.homeDirectory = "/home/ki11errabbit";
    home.packages = with pkgs; [
        discord
        slack
        signal-desktop
    ];

    wayland.windowManager.sway = {
        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            keybindings = {
                "${modifier}+Return" = "exec ${terminal}";
            };
        };
        extraConfig = ''
        '';

    };
}

