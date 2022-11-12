{ config, user, ... }:

{
  home.persistence."/nix/persist/home/${user}" = {
    allowOther = true;
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      #"nixland"
      { directory = "nixland"; method = "symlink"; }
      ".cache/doom"
      ".local/share/fcitx5"
      ".local/share/doom"
      ".local/share/TelegramDesktop"
      ".local/state/wireplumber"
      ".config/fcitx5"
      ".config/google-chrome"
    ];
    files = [
      ".config/zsh/history"
    ];
  };
}
