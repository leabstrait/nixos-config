{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.lnixosconf.system.env;
in
{
  options = {
    lnixosconf.system.env.sessionVariables = with types;
      mkOption {
        type = attrs;
        description = "A set of environment variables to set.";
      };

    lnixosconf.system.env.systemPackages = with types;
      mkOption {
        type = listOf package;
        default = [];
        description = "A list of packages to be available in the system";
      };



  };

  config = {
    environment = {
      systemPackages = cfg.systemPackages;

      sessionVariables = rec {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";

        # Not officially in the specification
        XDG_BIN_HOME = "$HOME/.local/bin";
        PATH = [
          "${XDG_BIN_HOME}"
        ];
      } // cfg.sessionVariables;
    };
  };
}
