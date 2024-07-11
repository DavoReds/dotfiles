{pkgs, ...}:
pkgs.writeShellApplication {
  name = "region-screenshot";

  runtimeInputs = with pkgs; [
    grim
    slurp
    swappy
  ];

  text = ''
    grim -g "$(slurp -w 0)" - | swappy -f -
  '';
}
