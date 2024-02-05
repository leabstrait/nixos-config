{ outputs, options, config, pkgs, lib, inputs, ... }:

with lib;
let
  cfg = config.lhmconf.nix;
in
{
  options.lhmconf.nix = with types; {
    enable = with types; mkEnableOption "Whether or not to manage nix configuration.";

    allowUnfree = with types; mkEnableOption "Whether or not to allow unfree packages.";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      config.allowUnfree = cfg.allowUnfree;
      overlays = [ outputs.overlays.additions ];
    };
  };
}
