{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    package = pkgs.mpd;
    #dataDir = .local/share/mpd;
    #dbFile = "\${dataDir}/tab_cache";
    #playlistDirectory = ${dataDir}/playlists;
    musicDirectory = "/nix/persist/home/hertz/Music/songs";
    extraConfig = ''
    '';
    network = {
      listenAddress = "127.0.0.1";
      #port = "6600";
      startWhenNeeded = true;
    };
  };
}
