{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.system;
in
{
  imports = [
    ./bluetooth
    ./boot/systemd
    ./env
    ./i18n
    ./networking
    ./sound
    ./time
    ./fonts
    ./graphics
  ];

  options = {
    lnixosconf.system = {
      stateVersion = with types; mkOption {
        type = str;
        description = "The first version of NixOS you have installed on this particular machine";
        # This option defines the first version of NixOS you have installed on this particular machine,
        # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
        #
        # Most users should NEVER change this value after the initial install, for any reason,
        # even if you've upgraded your system to a new NixOS release.
        #
        # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
        # so changing it will NOT upgrade your system.
        #
        # This value being lower than the current NixOS release does NOT mean your system is
        # out of date, out of support, or vulnerable.
        #
        # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
        # and migrated your data accordingly.
        #
        # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
      };
      autoUpgrade = {
        enable = with types; mkEnableOption "Whether or not to upgrade system automatically";
        allowReboot = with types; mkEnableOption "Whether or not to auto-reboot after upgrade";
      };
    };
  };

  config = {
    system.stateVersion = cfg.stateVersion;


    system.autoUpgrade.enable = cfg.autoUpgrade.enable;
    system.autoUpgrade.allowReboot = cfg.autoUpgrade.allowReboot;
  };

}
