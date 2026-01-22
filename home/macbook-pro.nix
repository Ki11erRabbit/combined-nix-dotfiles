{ lib, config, pkgs, ... }:

{
    home.homeDirectory = "/Users/ki11errabbit";
    home.packages = with pkgs; [
        iterm2
        coqPackages.vscoq-language-server
        discord
        slack
    ];
}


