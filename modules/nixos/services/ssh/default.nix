{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.services.ssh;
in
{
  options = {
    lnixosconf.services.ssh = {
      enable = with types; mkEnableOption "Whether or not to enable ssh support";

    };
  };

  config = mkIf cfg.enable {
    services.openssh.enable = true;
  };
}

