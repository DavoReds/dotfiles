{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = ../../../sddm;
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
