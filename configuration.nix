# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./grub-theme.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.theme = "${import ./sddm-theme.nix {inherit pkgs;}}";
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user accoun.enable = true;t. Don't forget to set a password with ‘passwd’.
  users.users.maxwaraxe = {
    isNormalUser = true;
    description = "maxwaraxe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    firefox
    brave
    rofi-wayland
    discord
    networkmanagerapplet
    swww
    libnotify
    webcord
    themechanger
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    xfce.thunar
    neofetch
    nix-prefetch-git
    gh
    #for sddm theme
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtmultimedia

    #waybar moduleupowers
    pamixer
    pavucontrol
    brightnessctl
    acpi
    playerctl
    rofi-power-menu
    telegram-desktop
    neofetch

    # Screenshot
    grim
    slurp
    wl-clipboard

    #hyprlock
    hyprlock
    wayland-protocols
    mesa

    #Some office
    libreoffice
    xarchiver
    gnome.file-roller
    udiskie
    btop
    qbittorrent
    
    ####
    lsb-release
    util-linux
    bash

    ## Development
    jetbrains.idea-community
    vscode-fhs
    git
    godot_4
    nodejs_21
    jdk22
    #Games
    superTuxKart

  ];

  
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "maxwaraxe" = import ./home.nix;
    };
  };
  fonts.packages = with pkgs;  [
    fira-code
    font-awesome
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerdfonts
    noto-fonts
    noto-fonts-emoji
    proggyfonts
  ];
  environment.sessionVariables = {
    #NIXOS_OZONE_WL = "1";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  hardware = {
    opengl.enable = true; 
    nvidia.modesetting.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  
  programs.zsh.enable = true;
  users.extraUsers.maxwaraxe = {
    shell = pkgs.zsh;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  services.udisks2 = {
    enable = true;
  };
}
