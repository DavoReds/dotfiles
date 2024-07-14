{
  lib,
  config,
  ...
}: {
  options.audio.enable = lib.mkEnableOption "Enables Pipewire";

  config = lib.mkIf config.audio.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      pulse.enable = true;
    };
  };
}
