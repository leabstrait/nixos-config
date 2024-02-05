{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.home.env;
in
{
  options = {
    lhmconf.home.env.sessionVariables = with types;
      mkOption {
        type = attrs;
        description = "A set of environment variables to set.";
      };

    lhmconf.home.env.packages = with types;
      mkOption {
        type = listOf package;
        default = [ ];
        description = "A list of packages to be available in the home";
      };
  };

  config = {
    home = {
      packages = cfg.packages;
      sessionVariables = cfg.sessionVariables;
    };
  };
}
