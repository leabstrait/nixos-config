{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.system.bluetooth;
in
{
  options = {
    lnixosconf.system.bluetooth = {
      enable = with types; mkEnableOption "Whether or not to enable bluetooth support";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true; # Bluetooth Manager
  };
}
