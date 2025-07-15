{ config, pkgs, lib, inputs, ... }: {
  #----------------------------------------------------------------------------#
  # SYSTEM PACKAGES                                                             #
  #----------------------------------------------------------------------------#
  environment.systemPackages = with pkgs; [
    # Core Development Tools
    vim          # terminal text editor
    neovim       # modern vim-based text editor
    gcc          # GNU Compiler Collection
    cmake        # cross-platform build system generator
    gnumake      # build automation tool
    git          # version control system
    vscode
    # from flakes
    inputs.zen-browser.packages.${pkgs.system}.default
    # Programming Languages
    python3      # python programming language
    nodejs       # JavaScript runtime environment
    go           # go programming language
    rustup       # rust toolchain installer
    lua          # lua programming language
    luarocks     # package manager for Lua modules
    btrfs-progs

    # Terminal Utilities
    kitty        # GPU-accelerated terminal emulator
    fzf          # command-line fuzzy finder
    fastfetch    # system information tool
    starship     # customizable shell prompt
    tmux         # terminal multiplexer
    btop         # resource monitor with graphs
    fd           # fast alternative to 'find'
    ripgrep      # fast alternative to grep
    jq           # command-line JSON processor
    unzip        # zip file extraction utility
    tree         # directory listing
    # File Management
    nemo         # graphical file manager
    yazi         # terminal file manager

    # System Tools
    nvtopPackages.full  # GPU process monitor
    lm_sensors   # hardware monitoring utilities
    pciutils     # PCI utilities for device inspection
    bluez        # bluetooth protocol stack
    eog
    qbittorrent-enhanced # torrent client    
    # Wayland Tools
    rofi-wayland # application launcher and window switcher
    xclip        # command line interface to X clipboard
    wl-clipboard # wayland clipboard utilities
    
    # Media & Viewers
    mupdf        # PDF viewer
    mpv          # video player
    gimp         # image editor
    # Screenshot & Recording
    grim         # screenshot utility for wayland
    slurp        # region selector for wayland
    hyprpicker   # color picker   

    # Desktop Environment
    pavucontrol  # PulseAudio volume control
    easyeffects  # pipewire equalizer
    gowall       # convert wallpaper to the theme
    pasystray    # audio settings in tray
    cava         # audio visualizer
    gparted 
    # Gaming
    mangohud     # performance overlay for games
    
    # Communication & Entertainment
    ayugram-desktop # messaging application
    vesktop         # chat and voice communication platform
    obs-studio      # screen recording
    nekoray         # discord, but better
    obsidian
    anki
    element-desktop
    spotify-player
    # System Libraries
    glib         # low-level core library for GNOME
    libnotify    # notification library
    socat        # listen to events on sockets

    # Gaming Platform
    (lutris.override {
      extraLibraries = pkgs: [
        wineWowPackages.waylandFull  # Wine with Wayland support
      ];
    })           # gaming platform manager

    # Network Tools
    networkmanagerapplet # network manager GUI

    libsForQt5.qtstyleplugin-kvantum # qt-theme framework
  ];

  #----------------------------------------------------------------------------#
  # FONTS                                                                       #
  #----------------------------------------------------------------------------#
  fonts.packages = builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
