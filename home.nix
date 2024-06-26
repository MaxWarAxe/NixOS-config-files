{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "maxwaraxe";
  home.homeDirectory = "/home/maxwaraxe";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value; even if you update Home Manager. If you do
  # want to update the value; then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello; world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages; for example; by applying
    # # overrides. You can do that directly here; just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example; this adds a command 'my-hello' to your
    # # environment=
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello; ${config.home.username}!"
    # '')
  ];
	imports = [
    ./waybar.nix
    ./firefox.nix
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/maxwaraxe/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  gtk = {
    enable = true;
    
    theme = {
      name = "Tokyonight-Dark-BL";
      package = pkgs.tokyo-night-gtk;
    };
    iconTheme = {
      name = "Tokyonight-Dark";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    }; 
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
     };
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -a";
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#default";
      config = "code /etc/nixos";
      hyprconf = "code /home/maxwaraxe/.config/hypr";
    };
    history.size = 100;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };

  programs.kitty = {
    enable = true;
    extraConfig = "confirm_os_window_close 0
                   window_padding_width 10";
    shellIntegration.enableZshIntegration = true;
    theme = "Night Owl";
  };

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
  };
  programs.feh = {
    enable = true;
  };
}