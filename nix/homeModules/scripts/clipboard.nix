{pkgs, ...}:
pkgs.writeShellApplication {
  name = "clipboard";

  runtimeInputs = with pkgs; [
    cliphist
    tofi
    wl-clipboard
  ];

  text = ''
    cliphist list | tofi --prompt-text 'Portapapeles: ' | cliphist decode | wl-copy
  '';
}
