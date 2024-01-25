{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.programs.git;
in
{
  options.lhmconf.programs.git = with types; {
    enable = mkEnableOption "Whether or not to enable git";
    userName = mkOption {
      type = str;
      description = "username for git";
    };
    userEmail = mkOption {
      type = str;
      description = "user email for git";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.git-crypt ];

    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      includes = [{
        path = ./.gitconfig;
      }];
    };
  };
}
