{ stdenv }: stdenv.mkDerivation {
  name = "wofi-powermenu";
  src = ./.;
  installPhase = ''
    mkdir -p $out/bin
    chmod +x wofi-powermenu
    cp wofi-powermenu $out/bin
  '';
}
