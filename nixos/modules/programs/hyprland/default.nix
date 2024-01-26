{ lib, config, pkgs,... }:
with lib;
let
  cfg = config.lnixosconf.programs.hyprland;
in
{
  options.lnixosconf.programs.hyprland = with types; {
    enable = mkEnableOption "Whether or not to enable hyprland";

  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
    };
  };
}
