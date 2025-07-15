{ config, pkgs, ... }: {
  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    targets = {
      starship.enable = true;
      waybar.enable = false;
      mako.enable = false;
      spicetify.enable = false;
    };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.inter;
        name = "Inter";
      };
      sizes = {
        applications = 9.5;
        desktop = 9.5;
        popups = 9.5;
        terminal = 11;
      };
    };
  };
}
