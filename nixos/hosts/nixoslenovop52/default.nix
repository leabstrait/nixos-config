{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
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
          LESS = "-SRXF";
          LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        };
        systemPackages = with pkgs; [
          # Essential utils
          gnumake
          lshw
          brightnessctl
          wget
          pamixer
          killall
          procps
          sysvtools
          sysvinit

          # Text Editors
          vim
          emacs
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

      xdg = {
        enable = true;
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

    security = {
      polkit = {
        enable = true;
      };
      pam = {
        services = {
          swaylock = {
            enable = true;
          };
        };
      };
      keyring = {
        enable = true;
      };
    };

    programs = {
      hyprland = {
        enable = true;
      };
    };

    services = {
      ssh = {
        enable = true;
      };

      geolocation.enable = true;


      fstrim = {
        enable = true;
      };

      greetd = {
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
}
