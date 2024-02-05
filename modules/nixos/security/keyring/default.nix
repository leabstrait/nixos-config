{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.security.keyring;
in
{
  options = {
    lnixosconf.security.keyring = {
      enable = with types; mkEnableOption "Whether or not to enable keyring";

    };
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
  };
}
