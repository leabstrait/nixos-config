{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.programs.vscode;
in
{
  options.lhmconf.programs.vscode = with types; {
    enable = mkEnableOption "Whether or not to enable vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
    };
  };
}
