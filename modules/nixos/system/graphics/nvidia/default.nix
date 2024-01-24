{ options, config, pkgs, lib, ... }:
with lib;
let
  cfg = config.lnixosconf.system.graphics.nvidia;
in
{
  options.lnixosconf.system.graphics.nvidia = {
    enable = with types; mkEnableOption "Whether or not to enable nvidia.";
    prime = {
      enable = with types; mkEnableOption "Whether or not to enable prime switcher.";
      intelBusId = with types; mkOption {
        type = str;
        description = "The bus ID of intel graphics card.";
      };
      nvidiaBusId = with types; mkOption {
        type = str;
        description = "The bus ID of nvidia graphics card.";
      };
    };
  };

  config = mkIf cfg.enable {
    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Prime

      prime = mkIf cfg.prime.enable {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = cfg.prime.intelBusId; #"PCI:0:2:0";
        nvidiaBusId = cfg.prime.nvidiaBusId; #"PCI:1:0:0";
      };
    };
  };
}
