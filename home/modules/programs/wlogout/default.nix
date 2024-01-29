{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.wlogout;
in
{
  options.lhmconf.programs.wlogout = with types; {
    enable = mkEnableOption "Whether or not to enable wlogout";
};

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}
