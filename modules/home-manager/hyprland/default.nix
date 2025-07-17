{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    systemd.variables = ["--all"];
    
    settings = {
      # Variables
      "$mod" = "SUPER";
      "$left" = "h";
      "$down" = "j";
      "$up" = "k";
      "$right" = "l";
      "$terminal" = "kitty";
      "$menu" = "rofi";

      # Monitor configuration
      monitor = [
        ",highrr,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      device = {
        name = "asuf1205:00-2808:0106-touchpad";
        accel_profile = "adaptive";
      };

      # Input configuration
      input = {
        sensitivity = 0;
        follow_mouse = 1;
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
          middle_button_emulation = false;
          tap-and-drag = true;
          drag_lock = false;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
      };

      # General settings
      general = {
        gaps_in = config.theme.spacing.xs;
        gaps_out = config.theme.spacing.s;
        border_size = config.theme.borderWidth;
        layout = "master";
        allow_tearing = false;

        "col.active_border" = lib.mkForce "rgb(${config.theme.colors.base03})";
        "col.inactive_border" = lib.mkForce "rgb(${config.theme.colors.base01})";
      };

      # Decoration
      decoration = {
        rounding = config.theme.borderRadius;
        active_opacity = 1.0;
        inactive_opacity = toString config.theme.opacity;

        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      # Animations
      animations = {
        enabled = false;
      };

      # Group configuration
      group = {
        groupbar = {
          enabled = false;
          stacked = false;
        };
        "col.border_active" = lib.mkForce "rgb(${config.theme.colors.base03})";
        "col.border_inactive" = lib.mkForce "rgb(${config.theme.colors.base01})";
      };


      # Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 2; # adaptive sync
      };

      # Window rules
      windowrule = [
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(nemo)$"
        "size 800 600, class:^(org.pulseaudio.pavucontrol)$"
        "opacity ${toString config.theme.opacity} ${toString config.theme.opacity}, floating:1"
      ];

      layerrule = [
        "blur, rofi"
      ];

      # Key bindings
      bind = [
        # Basic bindings
        "$mod, RETURN, exec, $terminal"
        "$mod, BACKSPACE, killactive"
        "$mod, D,  exec, $menu -show drun"
        "$mod, TAB, workspace, previous"
        "$mod, F, fullscreen" 
        # Movement
        "$mod, $left, movefocus, l"
        "$mod, $down, movefocus, d"
        "$mod, $up, movefocus, u"
        "$mod, $right, movefocus, r"

        "$mod SHIFT, $left, movewindow, l"
        "$mod SHIFT, $down, movewindow, d"
        "$mod SHIFT, $up, movewindow, u"
        "$mod SHIFT, $right, movewindow, r"

        # Workspaces
        "$mod, E, workspace, name:E"
        "$mod, Q, workspace, name:Q"
        "$mod, R, workspace, name:R"
        "$mod, T, workspace, name:T"
        "$mod, W, workspace, name:W"


        # Move container to workspace
        "$mod SHIFT, E, movetoworkspace, name:E"
        "$mod SHIFT, Q, movetoworkspace, name:Q"
        "$mod SHIFT, R, movetoworkspace, name:R"
        "$mod SHIFT, W, movetoworkspace, name:W"
        "$mod SHIFT, T, movetoworkspace, name:T"

        # Layout bindings
        "$mod, SLASH, layoutmsg, togglesplit"
        "$mod, COMMA, exec, bash ${../../../scripts/hypr-group.sh}"
        "$mod, j, changegroupactive, b"
        "$mod, k, changegroupactive, f"
        "$mod CTRL, F, fullscreen"
        "$mod, APOSTROPHE, exec, hyprctl --batch \"dispatch togglefloating; dispatch resizeactive exact 1000 800; dispatch centerwindow 1\""
        "$mod, SPACE, focusurgentorlast"

        "$mod, v, togglefloating"

        # Screenshots
      	"$mod, P, exec, hyprpicker"
        "$mod, Y, exec, grim -g \"$(slurp)\" ${config.home.homeDirectory}/Screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media keys
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${config.home.homeDirectory}/dotfiles/scripts/volume-notify.sh"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- && ${config.home.homeDirectory}/dotfiles/scripts/brightness-notify.sh"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+ && ${config.home.homeDirectory}/dotfiles/scripts/brightness-notify.sh"

        ", switch:on:Lid Switch, exec, hyprlock & systemctl suspend"
      ];

      # Mouse wheel workspace switching

      # Startup applications
      exec-once = [
        "hyprctl dispatch workspace name:T"
        "waybar"
        "nm-applet"
        "blueman-applet"
      ];

      # Environment variables
      env = [
        "XCURSOR_THEME,Capitaine Cursors (Gruvbox)"
        "XCURSOR_SIZE,16"
      ];
    };
  };
}
