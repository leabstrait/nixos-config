{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.waybar;
in
{
  options.lhmconf.programs.waybar = with types; {
    enable = mkEnableOption "Whether or not to enable waybar";
};

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };
  };
}
