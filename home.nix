{config, pkgs, lib, ...}:

let
  homeDirectory = "/home/sweaty";
in
{
  home.username = "sweaty";
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

 # Bash aliases
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix btw";
      nrs = "sudo nixos-rebuild switch";
      nec = "sudo vim /etc/nixos/configuration.nix";
      neh = "sudo vim /etc/nixos/home.nix";
      ninc = "sudo nix-instantiate --parse /etc/nixos/configuration.nix";
      ninh = "sudo nix-instantiate --parse /etc/nixos/home.nix";
      nix-current = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system/ | tail -1";
      nix-git = "sudo git -C /etc/nixos";
    };
  };

  # QT settings
  qt = {
    enable = true;
    qt6ctSettings = {
        Appearance = {
        style = "kvantum";
        icon_theme = "Papirus-Dark";
        standar_dialogs = "xdgdesktopportal";
      };
        Fonts = {
        fixed = "\"DejaVuSansM Nerd Font Mono,12\"";
        general = "\"DejaVu Sans,12\"";
      };
    };    
  };

  # GTK settings
  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };
    gtk4.extraConfig = {
      Settings = ''
      gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };
  };
  
  # Btop settings
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Catppuccin-Mocha";
      clock_format = "%I:%M:%S %p";
    };
    themes =
      {
        Catppuccin-Mocha = ''
          # Main background, empty for terminal default, need to be empty if you want transparent background
          theme[main_bg]="#1e1e2e"
          
          # Main text color
          theme[main_fg]="#cdd6f4"
          
          # Title color for boxes
          theme[title]="#cdd6f4"
          
          # Highlight color for keyboard shortcuts
          theme[hi_fg]="#89b4fa"
          
          # Background color of selected item in processes box
          theme[selected_bg]="#45475a"
          
          # Foreground color of selected item in processes box
          theme[selected_fg]="#89b4fa"
          
          # Color of inactive/disabled text
          theme[inactive_fg]="#7f849c"
          
          # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
          theme[graph_text]="#f5e0dc"
          
          # Background color of the percentage meters
          theme[meter_bg]="#45475a"
          
          # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
          theme[proc_misc]="#f5e0dc"
          
          # CPU, Memory, Network, Proc box outline colors
          theme[cpu_box]="#cba6f7" #Mauve
          theme[mem_box]="#a6e3a1" #Green
          theme[net_box]="#eba0ac" #Maroon
          theme[proc_box]="#89b4fa" #Blue
          
          # Box divider line and small boxes line color
          theme[div_line]="#6c7086"
          
          # Temperature graph color (Green -> Yellow -> Red)
          theme[temp_start]="#a6e3a1"
          theme[temp_mid]="#f9e2af"
          theme[temp_end]="#f38ba8"
          
          # CPU graph colors (Teal -> Lavender)
          theme[cpu_start]="#94e2d5"
          theme[cpu_mid]="#74c7ec"
          theme[cpu_end]="#b4befe"
          
          # Mem/Disk free meter (Mauve -> Lavender -> Blue)
          theme[free_start]="#cba6f7"
          theme[free_mid]="#b4befe"
          theme[free_end]="#89b4fa"
          
          # Mem/Disk cached meter (Sapphire -> Lavender)
          theme[cached_start]="#74c7ec"
          theme[cached_mid]="#89b4fa"
          theme[cached_end]="#b4befe"
          
          # Mem/Disk available meter (Peach -> Red)
          theme[available_start]="#fab387"
          theme[available_mid]="#eba0ac"
          theme[available_end]="#f38ba8"
          
          # Mem/Disk used meter (Green -> Sky)
          theme[used_start]="#a6e3a1"
          theme[used_mid]="#94e2d5"
          theme[used_end]="#89dceb"
          
          # Download graph colors (Peach -> Red)
          theme[download_start]="#fab387"
          theme[download_mid]="#eba0ac"
          theme[download_end]="#f38ba8"
          
          # Upload graph colors (Green -> Sky)
          theme[upload_start]="#a6e3a1"
          theme[upload_mid]="#94e2d5"
          theme[upload_end]="#89dceb"
          
          # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
          theme[process_start]="#74c7ec"
          theme[process_mid]="#b4befe"
          theme[process_end]="#cba6f7"
        '';
      };
  };

  # Fuzzel settings
  programs.fuzzel = {
    enable = true;
    settings = { 
      colors = {
        background="1e1e2eff";
        text="cdd6f4ff";
        prompt="bac2deff";
        placeholder="7f849cff";
        input="cdd6f4ff";
        match="89b4faff";
        selection="585b70ff";
        selection-text="cdd6f4ff";
        selection-match="89b4faff";
        counter="7f849cff";
        border="89b4faff";
      };
      border.width = 2;
    };
  };

  # Kitty settings
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
  };

  # Start swww
  services.awww.enable = true;

  # Hyprland settings
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.configType = "hyprlang";
  wayland.windowManager.hyprland.settings = {
    
    ### INITIALIZATION ###

    exec-once = [ 
      "sleep 1; awww img /etc/nixos/wallpaper.png"
      "ssh-add /home/sweaty/.ssh/envy_github"
      "ssh-add /home/sweaty/.ssh/envy_gitlab"
    ];
 
    ### LOOK AND FEEL ###
    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 0;
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    bezier = [
      "default, 0.05, 0.9, 0.1, 1.05"
      "wind, 0.05, 0.9, 0.1, 1.05"
      "overshot, 0.13, 0.99, 0.29, 1.08"
      "liner, 1, 1, 1, 1"
      "bounce, 0.4, 0.9, 0.6, 1.0"
      "snappyReturn, 0.4, 0.9, 0.6, 1.0"
      "slideInFromRight, 0.5, 0.0, 0.5, 1.0"
    ];

    animation = [
      "windows, 1, 3, snappyReturn, slidevert"
      "windowsIn, 1, 3, snappyReturn, slidevert right"
      "windowsOut, 1, 3, snappyReturn, slide"
      "windowsMove, 1, 3, bounce, slide"
      "fadeIn, 1, 5, default"
      "fadeOut, 1, 10, default"
      "fadeSwitch, 1, 10, default"
      "fadeShadow, 1, 10, default"
      "fadeDim, 1, 10, default"
      "workspaces, 1, 2, bounce, slidevert"
      "border, 1, 1, liner"
    ];

    layerrule = [
    ];

    dwindle = {
      preserve_split = true;
    };

    ### INPUT ###
    # Variables for keybinds
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$menu" = "fuzzel";

    # Key binds
    bind = 
      [
        "$mod, N, exec, $menu"
        "$mod, T, exec, $terminal"
        "$mod, C, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating,"
        "$mod, S, exec, hyprshot -m region"
      ]

    # Some insane Nix programming that iterates over workspace binds
      ++
      (builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ])9));

    # Mouse binds
    bindm = 
      [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

    # Function key binds for laptop
    bindel = 
      [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

  };
  
  # Environment Variables
  home.sessionVariables = {
    HYPRSHOT_DIR = homeDirectory + "/Pictures/screenshots";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # User packages
  home.packages = with pkgs; [
    # Fonts
    atkinson-hyperlegible-next

    # Terminal programs
    btop
    acpi
    fastfetch
    git
    zip
    unzip
    ffmpeg
    python3
    zola
    gource

    # Godot build requirements
    scons
    pkgconf
    gcc
    libxcursor
    libxinerama
    libxi
    libxrandr
    wayland-utils
    mesa
    libGL
    alsa-lib
    pulseaudio

    # Wayland accesories
    fuzzel
    dunst
    libnotify
    hyprshot
    awww
    hyprshutdown

    # QT applications
    kdePackages.dolphin
    kdePackages.qt6ct
    vlc
    prismlauncher
    rimsort
    qbittorrent
    dolphin-emu

    # GTK applications
    firefox
    remmina
    audacity
    inkscape
    vlc
    foliate
    transmission_4-qt6

    # Standalone applications
    godotPackages_4_7.godot
    zed-editor-fhs
    krita
    aseprite
    obs-studio
    itch
    blender
    renpy

    # Cardmaker Requirements
    mono

    # Electron app
  ];

  # home.activation = {
  #   source-bashrc = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     run source /home/sweaty/.bashrc
  #   '';
  # };
}
