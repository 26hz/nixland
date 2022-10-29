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

  home.persistence."/nix/persist/Plasma" = {
    allowOther = true;
    directories = [
      ".config/gtk-3.0"
      ".config/gtk-4.0"
      ".config/KDE"
      ".config/kde.org"
      ".config/plasma-workspace"
      ".config/xsettingsd"
      ".kde"
      ".local/share/baloo"
      ".local/share/dolphin"
      ".local/share/kactivitymanagerd"
      ".local/share/kate"
      ".local/share/klipper"
      ".local/share/konsole"
      ".local/share/kscreen"
      ".local/share/kwalletd"
      ".local/share/kxmlgui5"
      ".local/share/sddm"
    ];
    files = [
      ".config/akregatorrc"
      ".config/baloofilerc"
      ".config/dolphinrc"
      ".config/gtkrc"
      ".config/gtkrc-2.0"
      ".config/gwenviewrc"
      ".config/katerc"
      ".config/kateschemarc"
      ".config/katevirc"
      ".config/kcminputrc"
      ".config/kconf_updaterc"
      ".config/kded5rc"
      ".config/kdeglobals"
      ".config/kfontinstuirc"
      ".config/kglobalshortcutsrc"
      ".config/khotkeysrc"
      ".config/kiorc"
      ".config/kmixrc"
      ".config/konsolerc"
      ".config/kscreenlockerrc"
      ".config/kservicemenurc"
      ".config/ksmserverrc"
      ".config/ktimezonedrc"
      ".config/kwinrc"
      ".config/kwinrulesrc"
      ".config/kxkbrc"
      ".config/plasma-localerc"
      ".config/plasma-org.kde.plasma.desktop-appletsrc"
      ".config/plasmashellrc"
      ".config/powermanagementprofilesrc"
      ".config/spectaclerc"
      ".config/startkderc"
      ".config/systemsettingsrc"
      #".config/Trolltech.conf"
      ".local/share/krunnerstaterc"
      ".local/share/user-places.xbel"
      ".local/share/user-places.xbel.bak"
      ".local/share/user-places.xbel.tbcache"
    ];
  };
}
