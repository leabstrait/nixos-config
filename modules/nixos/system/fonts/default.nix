{ options, config, pkgs, lib, ... }:
with lib;
let
  cfg = config.lnixosconf.system.fonts;
in
{
  options.lnixosconf.system.fonts = with types; {
    enable = mkEnableOption "Whether or not to manage fonts.";
    packages = mkOption {
      type = (listOf package);
      description = "Custom font packages to install.";
    };
  };

  config = mkIf cfg.enable {
    fonts.enableDefaultPackages = true;
    fonts.packages = cfg.packages;
    environment.systemPackages = with pkgs; [ font-manager ];
  };
}
