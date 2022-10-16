{ config, lib, pkgs, inputs, user, ... }:

{

  imports = [
    ./persist/default.nix
    ./var/default.nix
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
    tdesktop
    google-chrome
  ];
}
