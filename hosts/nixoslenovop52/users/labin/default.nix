{ config, pkgs, ... }:

{
  imports = [
    ../../../common-host/common-user
  ];

  lhmconf = {
    home = {
      stateVersion = "23.11";

      username = "labin";

      env = {
        sessionVariables = {
          EDITOR = "emacs";
          BROWSER = "google-chrome-stable";
          NIXOS_CONFIG_DIR = "${config.home.homeDirectory}/nixos-config";
        };

        packages = with pkgs; [
          eza
          bat
        ];
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
      gammastep = {
        enable = true;
        provider = "geoclue2";
      };

      hyprpaper = {
        enable = true;
        # wallpaperFile = $HOME/nixos-config/wallpapers/space-station-ver-planet.png;
      };
    };
  };
}
