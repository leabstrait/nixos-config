{ lib, config, pkgs,... }:
with lib;
let
  cfg = config.lhmconf.programs.hyprland;
in
{
  options.lhmconf.programs.hyprland = with types; {
    enable = mkEnableOption "Whether or not to enable hyprland";

  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile (./hyprland.conf);
    };
  };
}
