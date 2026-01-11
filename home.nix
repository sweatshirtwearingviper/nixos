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
      nix-current = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system/";
      nix-git = "sudo git -C /etc/nixos";
    };
  };

  # GTK settings
  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  # Kitty settings
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
  };

  # Hyprland settings
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    ### LOOK AND FEEL ###
    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 0;
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    dwindle = {
      pseudotile = true;
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
        ",XF86AudioRaiseVolume, exec, wpctl set_volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set_volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
  };
  
  # User packages
  home.packages = with pkgs; [
    # Terminal programs
    btop
    acpi
    fastfetch
    git

    # Wayland accesories
    fuzzel
    dunst
    libnotify
    swww
    hyprshot

    # QT applications
    kdePackages.dolphin
    kdePackages.qt6ct

    # GTK applications
    firefox
    remmina

    # Standalone applications
    godot
    zed-editor-fhs

    # Electron app
  ];

  # home.activation = {
  #   source-bashrc = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     run source /home/sweaty/.bashrc
  #   '';
  # };
}
