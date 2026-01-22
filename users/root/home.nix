{ config, pkgs, ... }:

{
    
    home.stateVersion = "25.11"; # Please read the comment before changing.
    home.file = {
        ".config/kmonad/ibm-thinkpad-travel.kbd" = {
            text = builtins.readFile(../../kmonad/.config/kmonad/unicomp-model-m.kbd);
        };
        ".config/kmonad/unicomp-model-m.kbd".text = builtins.readFile(../../kmonad/.config/kmonad/unicomp-model-m.kbd);
    };
    programs.home-manager.enable = true;
}

