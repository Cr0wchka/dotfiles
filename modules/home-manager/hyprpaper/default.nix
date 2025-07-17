{ config, pkgs, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "${../../../assets/wallpapers/grey_lain_wallpaper.jpg}" ];

      wallpaper = [
        ",${../../../assets/wallpapers/grey_lain_wallpaper.jpg}"
      ];
    };
  };
}
