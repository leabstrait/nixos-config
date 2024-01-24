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

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = with pkgs; mkShell {
        packages = [
          pkgs.nix
          pkgs.git
          pkgs.home-manager
        ];
      };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixoslenovop52 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/common-host
            ./hosts/nixoslenovop52

            ./modules/nixos
          ];
        }; # nixoslenovop52
      };

      # Home Manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@hostname'
      homeConfigurations = {
        "labin@nixoslenovop52" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./hosts/common-host/common-user
            ./hosts/nixoslenovop52/users/labin

            ./modules/home-manager
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        }; # labin@nixoslenovop52
      };
    };
}
