{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.programs.chromium;
in
{
  options.lhmconf.programs.chromium = with types; {
    enable = mkEnableOption "Whether or not to enable chromium";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.google-chrome;
    };
  };
}
