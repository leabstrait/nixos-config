{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.services.swayidle;
in
{
  options.lhmconf.services.swayidle = with types; {
    enable = mkEnableOption "Whether or not to enable swayidle";
  };

  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
    };
  };
}
