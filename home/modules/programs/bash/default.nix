{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.programs.bash;
in
{
  options.lhmconf.programs.bash = with types; {
    enable = mkEnableOption "Whether or not to enable bash";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      bashrcExtra = (builtins.readFile ./.bashrc) +  (builtins.readFile ./alias.bashrc);
      
    };
  };
}
