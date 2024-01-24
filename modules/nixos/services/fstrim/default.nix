{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.services.fstrim;
in
{
  options = {
    lnixosconf.services.fstrim = {
      enable = with types; mkEnableOption "Whether or not to enable fstrim support";

    };
  };

  config = mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
