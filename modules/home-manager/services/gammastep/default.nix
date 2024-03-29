{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.services.gammastep;
in
{
  options.lhmconf.services.gammastep = with types; {
    enable = mkEnableOption "Whether or not to enable gammastep";
    provider = mkOption {
      type = str;
      description = "Location provider for gammastep";
    };
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      provider = cfg.provider;
      tray = true;
    };
  };
}
