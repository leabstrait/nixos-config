{ options, config, pkgs, lib, ... }:

with lib;
let
  cfg = config.lnixosconf.system.time;
in
{
  options = {
    lnixosconf.system.time = with types; {
      enable = mkEnableOption "Whether or not to configure timezone information.";
      timeZone = with types; mkOption {
        type = str;
        description = "The timezone of the system.";
      };
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;
  };
}
