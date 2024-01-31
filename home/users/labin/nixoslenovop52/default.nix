{ config, pkgs, ... }:

{
  imports = [
  ];

  lhmconf = {
    home = {
      stateVersion = "23.11";

      username = "labin";

      env = {
        sessionVariables = {
          EDITOR = "emacs";
          BROWSER = "google-chrome-stable";
          NIXOS_CONFIG_DIR = "${config.lhmconf.home.homeDirectory}/nixos-config";
        };

        packages = with pkgs; [
          eza

          bat

          ripgrep

          mc

          fzf
          highlight
          tree
        ];
      };

      xdg = {
        enable = true;
      };

      autoUpgrade = {
        enable = true;
        frequency = "weekly";
      };
    };

    nix = {
      enable = true;
      allowUnfree = true;
    };

    programs = {
      bash = {
        enable = true;
      };

      git = {
        enable = true;
        userName = "Labin Ojha";
        userEmail = "leabstrait@gmail.com";
      };

      gpg = {
        enable = true;
      };

      hyprland = {
        enable = true;
      };

      waybar = {
        enable = true;
      };

      swaylock = {
        enable = true;
      };

      wlogout = {
        enable = true;
      };

      wofi = {
        enable = true;
      };

      kitty = {
        enable = true;
      };

      starship = {
        enable = true;
      };

      vscode = {
        enable = true;
      };

      chromium = {
        enable = true;
      };
    };

    services = {
      swayidle = {
        enable = true;
      };

      gammastep = {
        enable = true;
        provider = "geoclue2";
      };

      hyprpaper = {
        enable = true;
        wallpapers = [
          {
            monitor = "eDP-1";
            wallpaperFile = "${config.lhmconf.home.homeDirectory}/Pictures/space-station-over-planet.jpg";
          }
        ];
      };

      mpvpaper = {
        enable = false;
        wallpapers = [
          {
            mpvOptions = "--no-audio --loop";
            monitor = "eDP-1";
            # wallpaperFile = "${config.lhmconf.home.homeDirectory}/Pictures/space-station-over-planet.mp4";
            wallpaperFile = "https://www.youtube.com/watch?v=P9C25Un7xaM&ab_channel=NASA";
          }
          # {
          #   mpvOptions = "";
          #   monitor = "eDP-2";
          #   wallpaperFile = "https://www.youtube.com/watch?v=P9C25Un7xaM&ab_channel=NASA";
          # }
        ];
      };
    };
  };
}
