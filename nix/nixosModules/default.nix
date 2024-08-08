{...}: {
  imports = [
    ./hardware/audio.nix
    ./hardware/battery.nix
    ./hardware/nbfc.nix
    ./hardware/system76.nix

    ./software/autologin.nix
    ./software/bluetooth.nix
    ./software/doas.nix
    ./software/docker.nix
    ./software/gaming.nix
    ./software/gdm.nix
    ./software/gnome.nix
    ./software/gpg.nix
    ./software/grub.nix
    ./software/kodi.nix
    ./software/lightdm.nix
    ./software/locale.nix
    ./software/plasma.nix
    ./software/podman.nix
    ./software/printer.nix
    ./software/sddm.nix
    ./software/systemd-boot.nix
    ./software/thunar.nix
    ./software/xfce.nix

    ./services/jellyfin.nix
    ./services/kanata.nix
    ./services/nextdns.nix
    ./services/openssh.nix
    ./services/rdp.nix
  ];
}
