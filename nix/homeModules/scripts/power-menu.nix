{pkgs, ...}:
pkgs.writeShellApplication {
  name = "power-menu";

  runtimeInputs = with pkgs; [
    libnotify
    tofi
  ];

  text = ''
      echo -e "Bloquear\nSuspender\nApagar\nReiniciar\nLogout" | tofi --prompt-text "Acción: " | while read -r selection; do
      case $selection in
        Bloquear)
          swaylock
          ;;
        Suspender)
          systemctl suspend && swaylock
          ;;
        Apagar)
          systemctl poweroff
          ;;
        Reiniciar)
          systemctl reboot
          ;;
        Logout)
          hyprctl dispatch exit
          ;;
        *)
          notify-send "Selección inválida"
          ;;
      esac
    done
  '';
}
