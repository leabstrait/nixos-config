{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.programs.fzf;
in
{
  options.lhmconf.programs.fzf = with types; {
    enable = mkEnableOption "Whether or not to enable fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
    };
  };
}
