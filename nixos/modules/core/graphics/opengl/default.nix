{ options, config, pkgs, lib, ... }:
with lib;
let
  cfg = config.lnixosconf.system.graphics.opengl;
in
{
  options.lnixosconf.system.graphics.opengl = {
    enable = with types; mkEnableOption "Whether or not to enable OpenGL.";
  };

  config = mkIf cfg.enable {
    # Enable OpenGL
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };
  };
}
