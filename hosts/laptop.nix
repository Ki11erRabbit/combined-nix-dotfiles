{ config, pkgs, ... }:

{
    networking.hostName = "think-nix-t480"; # Define your hostname.

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "colemak_dh";
    };
   
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
    
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    programs.mango = {
        enable = true;
    }; 
    
    environment.systemPackages = with pkgs; [
        
    ];

    services.blueman.enable = true;

    hardware.steam-hardware.enable = true;

}

