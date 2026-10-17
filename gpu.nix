{ config, pkgs, ... }: {
  # Keep the NVIDIA driver loaded so nvidia-smi / nvidia-powerd work even
  # when no client is attached to the GPU.
  systemd.services."nvidia-persistence-mode" = {
    description = "Enable NVIDIA GPU persistence mode";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = [ "${config.hardware.nvidia.package.bin}/bin/nvidia-smi -pm 1" ];
    };
  };

  # NVIDIA Dynamic Boost daemon: dynamically manages the dGPU's TGP
  # (5-115 W) based on thermals. On this laptop the platform firmware
  # rejects `nvidia-smi -pl`, so this is the supported way to let the
  # GPU draw more than the 55 W default when there is thermal headroom.
  # Note: it shells out to lscpu, so util-linux must be on its PATH.
  systemd.services.nvidia-powerd = {
    description = "NVIDIA Dynamic Boost power management daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "nvidia-persistence-mode.service" "dbus.service" ];
    path = [ pkgs.util-linux ];
    serviceConfig = {
      ExecStart = "${config.hardware.nvidia.package.bin}/bin/nvidia-powerd";
      Restart = "on-failure";
    };
  };
}
