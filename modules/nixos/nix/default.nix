{ outputs, options, config, pkgs, lib, inputs, ... }:

with lib;
let
  cfg = config.lnixosconf.nix;
in
{
  options.lnixosconf.nix = with types; {
    enable = with types; mkEnableOption "Whether or not to manage nix configuration.";
    package = with types; mkOption { type = package; description = "Which nix package to use."; };

    allowUnfree = with types; mkEnableOption "Whether or not to allow unfree packages.";
    enableFlakes = with types; mkEnableOption "Whether or not to enable flakes";
    enableNixCommand = with types; mkEnableOption "Whether or not to enable nix command";

    autoOptimiseStore = with types; mkEnableOption "Whether or not to optimise store every build";
    garbageCollection = with types; mkEnableOption "Whether or not to enable garbage collection";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nixpkgs-fmt
      rnix-lsp
    ];

    nix = {
      package = cfg.package;

      settings = {
        experimental-features = [
          (mkIf
            cfg.enableNixCommand
            "nix-command")
          (mkIf
            cfg.enableFlakes
            "flakes")
        ];
        auto-optimise-store = cfg.autoOptimiseStore;
      };

      gc = mkIf cfg.garbageCollection {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    nixpkgs = {
      config.allowUnfree = cfg.allowUnfree;
      overlays = [ outputs.overlays.additions ];
    };
  };
}
