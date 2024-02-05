{
  description = "Labin's NixOS Configuration Flake - lnixosconf";

  inputs = {
    # nixpkgs (unstable)
    nixpkgs = {
      url = "github:nixos/nixpkgs";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;

      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # default devShell for maintenace and installation purpose
      devShells.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux; mkShell {
        packages = [
          nixpkgs.legacyPackages.x86_64-linux.nix
          nixpkgs.legacyPackages.x86_64-linux.git
          nixpkgs.legacyPackages.x86_64-linux.home-manager
        ];
      };

      # Formatter for your nix files, available through 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixoslenovop52 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./hosts/nixoslenovop52
          ];
        }; # nixoslenovop52
      };

      # Home Manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username-at-hostname'
      homeConfigurations = {
        "labin-at-nixoslenovop52" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main home-manager configuration file <
            ./homes/labin/nixoslenovop52
          ];
        }; # labin-at-nixoslenovop52
      };
    };
}
