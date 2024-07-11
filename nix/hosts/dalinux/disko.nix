{device ? throw "Set this option to your storage device, e.g. /dev/sda", ...}: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            name = "ESP";
            start = "1M";
            end = "128M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "/root" = {
                  mountOptions = ["subvol=root" "compress-force=zstd" "noatime"];
                  mountpoint = "/";
                };

                "/home" = {
                  mountOptions = ["subvol=home" "compress-force=zstd" "noatime"];
                  mountpoint = "/home";
                };

                "/nix" = {
                  mountOptions = ["subvol=nix" "compress-force=zstd:6" "noatime"];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}
