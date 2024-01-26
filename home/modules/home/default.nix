{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.home;
in
{
  imports = [
    ./env
  ];

  options = {
    lhmconf.home = with types;{
      stateVersion = mkOption {
        type = str;
        description = "the Home Manager release that your configuration is compatible with";
        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
      };
      username = mkOption {
        type = str;
        description = "username for Home Manager user";
      };
      homeDirectory = mkOption {
        type = str;
        default = config.home.homeDirectory;
        description = "username for Home Manager user";
      };
      autoUpgrade = {
        enable = with types; mkEnableOption "Whether or not to upgrade home-manager automatically";
        frequency = mkOption {
          type = str;
          description = "Auto-upgrade frequency";
        };
      };
    };
  };

  config = {
    home = {
      stateVersion = cfg.stateVersion;

      username = cfg.username;
      homeDirectory = "/home/${cfg.username}";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    services.home-manager.autoUpgrade = mkIf cfg.autoUpgrade.enable {
      enable = true;
      frequency = cfg.autoUpgrade.frequency;
    };
  };
}
