{
  hardware.logitech.wireless.enable = true;

  services.logiops = {
    enable = true;
    config = {
      devices = [
        {
          name = "MX Master 3S";
          dpi = 3500;
        }
      ];
    };
  };
}
