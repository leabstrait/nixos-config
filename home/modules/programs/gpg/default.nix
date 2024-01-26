{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.gpg;
in
{
  options.lhmconf.programs.gpg = with types; {
    enable = mkEnableOption "Whether or not to enable gpg";
};

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "tty";
      enableBashIntegration = true;
    };
  };
}
