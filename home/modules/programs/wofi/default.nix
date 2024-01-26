{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.wofi;
in
{
  options.lhmconf.programs.wofi = with types; {
    enable = mkEnableOption "Whether or not to enable wofi";

  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
