{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    # User requested addons
    ./users/labin/host-addons
  ];

  lnixosconf = {

    system = {

      stateVersion = "23.11";

      boot = {
        enable = true;
      };

      networking = {
        enable = true;
        hostName = "nixoslenovop52";
      };

      sound = {
        enable = true;
      };

      bluetooth = {
        enable = true;
      };

      time = {
        enable = true;
        timeZone = "Europe/London";
      };

      i18n = {
        enable = true;
        defaultLocale = "en_GB.UTF-8";
        consoleKeyMap = "uk";
      };

      env = {
        sessionVariables = {
          PAGER = "most";
          LESS = "-SRXF";
          LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        };
        systemPackages = with pkgs; [
          gnumake
          lshw
          vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
          wget
          most
          emacs
          vscode
          wofi
          google-chrome
          hyprpaper
          brightnessctl
          pamixer
          killall
          pcmanfm
          tmux
          # nixpkgs-fmt
        ];
      };

      fonts = {
        enable = true;
        packages = with pkgs; [
          jetbrains-mono
          font-awesome
          (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];
      };

      graphics = {
        opengl = {
          enable = true;
        };
        nvidia = {
          enable = true;
          prime = {
            enable = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
          };
        };
      };

      autoUpgrade = {
        enable = true;
        allowReboot = false;
      };

    };

    nix = {
      enable = true;

      package = pkgs.nix;
      enableFlakes = true;
      enableNixCommand = true;
      autoOptimiseStore = true;

      garbageCollection = true;

      allowUnfree = true;
    };

    services = {
      ssh = {
        enable = true;
      };


      fstrim = {
        enable = true;
      };
    };

    users = {
      normalUsers = [
        {
          name = "labin";
          fullName = "Labin Ojha";
          email = "leabstrait@gmail.com";
          initialPassword = "pass";
          extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
          extraOptions = { };
        }
        {
          name = "labin2";
          fullName = "Labin Ojha";
          email = "leabstrait@gmail.com";
          initialPassword = "pass";
          extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
          extraOptions = { };
        }
      ];
    };
  };

  # Enable Hyprland WM
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
}
