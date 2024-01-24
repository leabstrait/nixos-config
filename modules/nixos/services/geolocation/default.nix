{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.services.geolocation;
in
{
  options = {
    lnixosconf.services.geolocation = {
      enable = with types; mkEnableOption "Whether or not to enable geolocation support";

    };
  };

  config = mkIf cfg.enable {
    # Enable geoclue2
    services.geoclue2.enable = true;
  };
}
