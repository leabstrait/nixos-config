{ options, config, pkgs, lib, ... }:

with lib;

let
  cfg = config.lnixosconf.services.greetd;

  sessionPackages = config.services.xserver.displayManager.sessionPackages;
  sessionPackagesWithWaylandSessions = map (pkg: "${pkg}/share/wayland-sessions") sessionPackages;
  sessionPackagesWithWaylandSessionsPath = lib.concatStringsSep ":" sessionPackagesWithWaylandSessions;

in
{
  options = {
    lnixosconf.services.greetd = {
      enable = with types; mkEnableOption "Whether or not to enable greetd support";
    };
  };

  config = mkIf cfg.enable
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "tuigreet --user-menu --time  --sessions ${sessionPackagesWithWaylandSessionsPath}";
          };
        };
      };
      environment.systemPackages = [
        pkgs.greetd.tuigreet
      ];
    };
}
