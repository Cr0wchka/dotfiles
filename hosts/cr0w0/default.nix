{ config, pkgs, ... }: {
  imports = [
   ./hardware-configuration.nix
  ];

  #----------------------------------------------------------------------------#
  # NIX SETTINGS                                                               #
  #----------------------------------------------------------------------------#
  nix =  {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  #----------------------------------------------------------------------------#
  # HARDWARE CONFIGURATION                                                     #
  #----------------------------------------------------------------------------#
  hardware.graphics = {
  enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  open = false;
  nvidiaSettings = true;
  };
  #----------------------------------------------------------------------------#
  # BOOT & KERNEL                                                              #
  #----------------------------------------------------------------------------#
    boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    consoleLogLevel = 3;

    plymouth = {
      enable = true;
    };

    initrd = {
      verbose = false;
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };    
  #----------------------------------------------------------------------------#
  # NETWORKING                                                                 #
  #----------------------------------------------------------------------------#
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  #----------------------------------------------------------------------------#
  # SYSTEM SETTINGS                                                            #
  #----------------------------------------------------------------------------#
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

 
  #----------------------------------------------------------------------------#
  # SYSTEMD SERVICES                                                           #
  #----------------------------------------------------------------------------#
  systemd = {
    tmpfiles.rules = let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
  };

   services.resolved = {
   enable = true;
   dnssec = "allow-downgrade";
   };
  #----------------------------------------------------------------------------#
  # PROGRAMS                                                                   #
  #----------------------------------------------------------------------------#
  programs = {
    nix-ld = {
      enable = true;
    };
    zsh.enable = true;
    starship.enable = true;
    steam = {
      enable = true;
    };
    gamemode.enable = true;
    dconf.enable = true;

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
        };
      };
    };

    hyprland = {
      enable = true;
      withUWSM  = true;
    };
  };
   
  virtualisation.docker.enable = true; 
  #----------------------------------------------------------------------------#
  # SECURITY                                                                   #
  #----------------------------------------------------------------------------#
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    doas.enable = true;
    sudo.enable = false;
    doas.extraRules = [{
    users = ["cr0w0"];
    keepEnv = true;
    persist = true;
    }];
  };

  #----------------------------------------------------------------------------#
  # SERVICES                                                                   #
  #----------------------------------------------------------------------------#
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    envfs.enable = true;
    greetd = {
      enable = false;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet \
                    --time --time-format '%I:%M %p | %a • %h | %F' \
                    --cmd 'uwsm start hyprland'";
          user = "greeter";
        };
      };
    };
    displayManager.gdm.enable = true;
    xserver.xkb = {
      layout = "us,ru";
      options = "grp:rshift_toggle";
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
    };
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              rightcontrol = "rightmeta";
            };
            otherlayer = {};
          };
        };
      };
    };
  };

  #----------------------------------------------------------------------------#
  # USERS                                                                      #
  #----------------------------------------------------------------------------#
  users = {
    users.cr0w0 = {
      isNormalUser = true;
      description = "cr0w0";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [];
    };
    defaultUserShell = pkgs.zsh;
  };

 programs.nekoray = {
 enable = true;
 tunMode.enable = true;
 tunMode.setuid = true;
 };
  #----------------------------------------------------------------------------#
  # ENVIRONMENT                                                                #
  #----------------------------------------------------------------------------#
  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.sessionVariables = {
    XCURSOR_PATH = [
      "${pkgs.capitaine-cursors-themed}/share/icons"
    ];
    NIXOS_OZONE_WL = "1";

    LUA_PATH = "${pkgs.luarocks}/share/lua/5.1/?.lua;${pkgs.luarocks}/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "${pkgs.luarocks}/lib/lua/5.1/?.so;;";
  };
}
