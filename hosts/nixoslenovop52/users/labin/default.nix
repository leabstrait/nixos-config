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

    programs = {
      git = {
        enable = true;
        userName = "Labin Ojha";
        userEmail = "leabstrait@gmail.com";
      };

      gpg = {
        enable = true;
      };

      kitty = {
        enable = true;
      };

      starship = {
        enable = true;
      };
    };

    services = {
      gammastep = {
        enable = true;
        provider = "geoclue2";
      };
    };
  };
}
