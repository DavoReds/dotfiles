{
  lib,
  config,
  ...
}: {
  options.audio.enable = lib.mkEnableOption "Enables Pipewire";

  config = lib.mkIf config.audio.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
