{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.security.pam.services.swaylock;
in
{
  options = {
    lnixosconf.security.pam.services.swaylock = {
      enable = with types; mkEnableOption "Whether or not to enable pam support";

    };
  };

  config = mkIf cfg.enable {
    security.pam.services.swaylock = {
      enableGnomeKeyring = true;
    };
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
    };
  };
}
