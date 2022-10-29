{ config, lib, pkgs, inputs, user, ... }:

{

  imports = [
    #./emacs/default.nix
    ./doom/default.nix
    ./persist/default.nix
    ./var/default.nix
    ./mpd/default.nix
    ./mpv/default.nix
    ./neovim/default.nix
    ./git/default.nix
    ./zsh/default.nix
    ./starship/default.nix
  ];

  nixpkgs.config.allowUnfree = true;


  programs = {
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    fish
    tdesktop
    google-chrome
    neofetch
  ];
  xsession = {
    profileExtra = ''
      emacs --daemon &
    '';
  };
}
