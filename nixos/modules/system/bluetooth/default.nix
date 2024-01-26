{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.system.sound;
in
{
  options = {
    lnixosconf.system.sound = {
      enable = with types; mkEnableOption "Whether or not to enable sound support";
    };
  };

  config = mkIf cfg.enable {
    sound = {
      enable = true;
    };
    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull; # Extra codecs apart from SBC: AAC, APTX, APTX-HD, LDAC
    };
  };
}
