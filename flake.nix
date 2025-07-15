{
  description = "Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    spicetify-nix = {
    url = "github:Gerg-L/spicetify-nix";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    
    textfox = {
     url = "github:adriankarlen/textfox";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, zen-browser, spicetify-nix, textfox }:
  {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager

          ./hosts/cr0w0/default.nix
          ./hosts/cr0w0/packages.nix

          {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
              users.cr0w0 = {
                imports = [
                  ./hosts/cr0w0/home.nix
                  ./modules/home-manager/theme/default.nix
                  ./modules/home-manager/gtk/default.nix
                  ./modules/home-manager/qt/default.nix
                  ./modules/home-manager/waybar/default.nix
                  ./modules/home-manager/mako/default.nix
                  ./modules/home-manager/mangohud/default.nix
                  ./modules/home-manager/rofi/default.nix
                  ./modules/home-manager/hyprland/default.nix
                  ./modules/home-manager/hyprlock/default.nix
                  ./modules/home-manager/hypridle/default.nix
                  ./modules/home-manager/hyprpaper/default.nix
                  ./modules/home-manager/nvim/default.nix
                  ./modules/home-manager/kitty/default.nix
                  ./modules/home-manager/tmux/default.nix
                  ./modules/home-manager/yazi/default.nix
                  ./modules/home-manager/starship/default.nix
                  ./modules/home-manager/zsh/default.nix
                  ./modules/home-manager/fastfetch/default.nix
                  ./modules/home-manager/spicetify/default.nix
                  ./modules/home-manager/textfox/default.nix
                  stylix.homeModules.stylix
                  ./modules/home-manager/stylix/default.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
