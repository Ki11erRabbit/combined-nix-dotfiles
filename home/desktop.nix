{ lib, inputs, config, pkgs, channels,  ... }:

{
    home.packages = with pkgs; [
        obs-studio
        godot-mono
    ];
}

