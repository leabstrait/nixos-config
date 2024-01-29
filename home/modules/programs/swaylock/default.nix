{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.swaylock;
in
{
  options.lhmconf.programs.swaylock = with types; {
    enable = mkEnableOption "Whether or not to enable swaylock";
};

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
    };
  };
}
