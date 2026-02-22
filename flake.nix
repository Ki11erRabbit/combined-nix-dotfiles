{
    description = "My NixOS shared Config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        unstable-pkgs.url = "nixpkgs/nixos-unstable";
        old-pkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with
            # the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs.
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };
        mango = {
            url = "github:DreamMaoMao/mango";
            inputs.nixpkgs.follows = "unstable-pkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, unstable-pkgs, old-pkgs, zen-browser, mango, ... }: 
    let 
        mkNixosSystem = system: hostname: platform:
            nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    mango.nixosModules.mango
                    ./hosts/common.nix
                    ./hosts/${platform}.nix
                    ./hosts/${platform}-unstable.nix
                    ./hardware/${hostname}.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./users/root/home.nix;
                    }
                ];
                specialArgs = { inherit hostname; };
            };
        mkHome = system: username: hostname: platform:
            home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};
                modules = [
                    mango.hmModules.mango
                    zen-browser.homeModules.beta
                    ./home/${username}.nix
                    ./home/${hostname}.nix
                    ./home/${platform}.nix
                    ./home/${platform}-unstable.nix
                ];
                extraSpecialArgs = { inherit system username hostname; unstable = unstable-pkgs.legacyPackages.${system}; };
            };
    in
    {
        nixosConfigurations = {
            nix-desktop = mkNixosSystem "x86_64-linux" "nix-desktop" "desktop";
            #nix-T480 = mkNixosSystem "x86_64-linux" "think-nix-T480" "laptop";
        };
        homeConfigurations = {
            "ki11errabbit@nix-desktop" = mkHome "x86_64-linux" "ki11errabbit" "nix-desktop" "desktop";
            "ki11errabbit@macbook-pro" = mkHome "aarch64-darwin" "ki11errabbit" "macbook-pro" "macbook";
        };
    };
}
