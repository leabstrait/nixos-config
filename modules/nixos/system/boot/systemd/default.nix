{ options, config, pkgs, lib, ... }:
with lib;
let
  cfg = config.lnixosconf.system.boot;
in
{
  options.lnixosconf.system.boot = {
    enable = with types; mkEnableOption "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    # boot.loader.systemd-boot.configurationLimit = 10;
    boot.loader.efi.canTouchEfiVariables = true;

    # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
    boot.loader.systemd-boot.editor = false;
  };
}
