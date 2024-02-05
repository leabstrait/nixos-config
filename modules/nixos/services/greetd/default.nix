{ options, config, pkgs, lib, ... }:

with lib;

let
  cfg = config.lnixosconf.services.greetd;

  sessionPackages = config.services.xserver.displayManager.sessionPackages;
  sessionPackagesWithWaylandSessions = map (pkg: "${pkg}/share/wayland-sessions") sessionPackages;
  sessionPackagesWithWaylandSessionsPaths = lib.concatStringsSep ":" sessionPackagesWithWaylandSessions;

in
{
  options = {
    lnixosconf.services.greetd = {
      enable = with types; mkEnableOption "Whether or not to enable greetd support";
    };
  };

  config = mkIf cfg.enable
    {
      environment.systemPackages = [
        pkgs.greetd.tuigreet
      ];

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "tuigreet --issue --time --user-menu --asterisks --remember --remember-user-session --sessions ${sessionPackagesWithWaylandSessionsPaths}";
          };
        };
      };

    };
}
