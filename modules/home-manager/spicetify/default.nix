{ config, pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {

  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];
  nixpkgs.config.allowUnfree = true;
  programs.spicetify = {
    enable = true;
  enabledExtensions = with spicePkgs.extensions; [
       adblockify
       keyboardShortcut
       history
       hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
     ];   
    theme = spicePkgs.themes.text;
    colorScheme = "Gruvbox";
  };
}
