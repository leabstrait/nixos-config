{ options, config, pkgs, lib, inputs, ... }:

with lib;
let
  cfg = config.lhmconf.home.xdg;
in
{
  options.lhmconf.home.xdg = with types; {
    enable = with types; mkEnableOption "Whether or not to manage xdg configuration.";

  };

  config = mkIf cfg.enable {
      xdg.enable = true;
      xdg.mime.enable = true;
  };
}
