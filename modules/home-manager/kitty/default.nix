{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''

      # BEGIN_KITTY_FONTS
      # Font ligatures settings for Jet Brains Mono Font:
      # https://github.com/JetBrains/JetBrainsMono/wiki/OpenType-features
      font_family      family='TamzenMono Nerd Font' style=Light
      bold_font        family='TamzenMono Nerd Font' style=Bold
      italic_font      family='TamzenMono Nerd Font' style='Light Italic'
      bold_italic_font family='TamzenMono Nerd Font' style='Bold Italic'
      # END_KITTY_FONTS

      # BEGIN_KITTY_SYMBOL_MAPS
      symbol_map U+E000-U+F8FF,U+F0000-U+FFFFF,U+100000-U+10ffff JetBrainsMonoNL Nerd Font
      # END_KITTY_SYMBOL_MAPS
    '';
  };
}
