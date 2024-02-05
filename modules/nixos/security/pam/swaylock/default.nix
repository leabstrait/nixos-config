{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.security.pam.swaylock;
in
{
  options = {
    lnixosconf.security.pam.swaylock = {
      enable = with types; mkEnableOption "Whether or not to configure pam for swaylock";

    };
  };

  config = mkIf cfg.enable {
    security.pam.services.swaylock = { };
  };
}
