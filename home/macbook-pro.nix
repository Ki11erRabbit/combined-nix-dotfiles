{ lib, config, pkgs, ... }:

{
    home.stateVersion = "25.11";
    home.homeDirectory = "/Users/ki11errabbit";
    home.packages = with pkgs; [
        iterm2
        coqPackages.vscoq-language-server
        discord
        slack
    ];
}


