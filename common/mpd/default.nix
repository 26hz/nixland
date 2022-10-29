{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    package = pkgs.mpd;
    #dataDir = "$XDG_DATA_HOME/mpd";
    #dbFile = "\${dataDir}/tab_cache";
    #playlistDirectory = ${dataDir}/playlists;
    musicDirectory = "/nix/persist/home/hertz/Music/songs";
    extraConfig = ''
log_file "$HOME/.local/share/mpd/log"
pid_file "$HOME/.local/share/mpd/pid"
user "hertz"
auto_update "yes"
follow_outside_symlinks "yes"
follow_inside_symlink "yes"
zeroconf_enabled "yes"
zeroconf_name "mpd"

audio_output {
	type			"fifo"
	name			"Visualizer feed"
	path			"/tmp/mpd.fifo"
	format		"44100:16:2"
	enabled	"yes"
}

    '';
    network = {
      listenAddress = "any";
      port = 6600;
      startWhenNeeded = true;
    };
  };
}
