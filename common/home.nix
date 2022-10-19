{ config, lib, pkgs, inputs, user, ... }:

{

  imports = [
    ./emacs/default.nix
    ./persist/default.nix
    ./var/default.nix
    ./neovim/default.nix
    ./git/default.nix
    ./zsh/default.nix
    ./starship/default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  manual.manpages.enable = false;

  programs = {
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    tdesktop
    google-chrome
  ];
}
