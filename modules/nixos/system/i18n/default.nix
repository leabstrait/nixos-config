{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.lnixosconf.system.i18n;
in
{
  options = {
    lnixosconf.system.i18n = with types; {
      enable = mkEnableOption  "Whether or not to manage i18n settings.";
      defaultLocale = with types; mkOption {
        type = str;
        description = "The defaultLocale of the system.";
      };
      consoleKeyMap = with types; mkOption {
        type = str;
        description = "The consoleKeyMap of the system.";
      };
    };
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = cfg.defaultLocale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.defaultLocale;
      LC_IDENTIFICATION = cfg.defaultLocale;
      LC_MEASUREMENT = cfg.defaultLocale;
      LC_MONETARY = cfg.defaultLocale;
      LC_NAME = cfg.defaultLocale;
      LC_NUMERIC = cfg.defaultLocale;
      LC_PAPER = cfg.defaultLocale;
      LC_TELEPHONE = cfg.defaultLocale;
      LC_TIME = cfg.defaultLocale;
    };
    console = {
      font = "Lat2-Terminus16";
      keyMap = mkForce cfg.consoleKeyMap;
    };
  };
}
