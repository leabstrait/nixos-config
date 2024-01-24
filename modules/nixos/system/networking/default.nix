{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.system.networking;
in
{
  options = {
    lnixosconf.system.networking = {
      enable = with types; mkEnableOption "Whether or not to enable networking support";
      hostName = with types; mkOption {
        type = str;
        description = "The hostname of the system.";
      };
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = cfg.hostName;
      networkmanager = {
        enable = true;
      };
    };
  };
}
