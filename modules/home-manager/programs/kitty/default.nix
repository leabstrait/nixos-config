{ lib, config, ... }:
with lib;
let
  cfg = config.lhmconf.programs.kitty;
in
{
  options.lhmconf.programs.kitty = with types; {
    enable = mkEnableOption "Whether or not to enable kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      extraConfig = ''
        font_family      Jetbrains Mono
        bold_font        Jetbrains Mono Bold
        italic_font      Jetbrains Mono Italic
        bold_italic_font Jetbrains Mono Bold Italic
      '';
    };
  };
}
