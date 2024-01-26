{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.starship;
in
{
  options.lhmconf.programs.starship = with types; {
    enable = mkEnableOption "Whether or not to enable starship";
};

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
