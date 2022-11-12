{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit";
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;
    #cdpath = [];
    defaultKeymap = "emacs";
    dirHashes = {
      docs  = "$HOME/Documents";
      vids  = "$HOME/Videos";
      dl    = "$HOME/Downloads";
    };
    dotDir = ".config/zsh";
    #envExtra = ""; #Extra commands that should be added to .zshenv
    initExtra = ''
      my-backward-delete-word() {
        #local WORDCHARS='~!#$%^&*(){}[]<>?.+;-'
        local WORDCHARS="."
        zle backward-delete-word
      }
      my-backward-kill-word() {
        local WORDCHARS="."
        zle backward-kill-word
      }
      zle -N my-backward-delete-word
      zle -N my-backward-kill-word
      bindkey '^W' my-backward-kill-word
      bindkey '^[^?' my-backward-delete-word
      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line
    ''; #Extra commands that should be added to .zshrc
    #localVariables = {};
    #loginExtra = {};
    #logoutExtra = {};
    #profileExtra = {};
    #sessionVariables = { MAILCHECK = 30; };
    shellAliases = {
      cdconf = "cd $HOME/nixland";
      nixupdate = "nix flake update";
      nixupgrade = "export HOST=`hostname`; doas nixos-rebuild switch --flake .#\${HOST}";
      dh = "df -h -x fuse --output=source,fstype,size,pcent,target";
      fars = "curl -F 'c=@-' 'https://fars.ee/' <";
      es = "emacsclient -t -a 'emacs' ";
      emms = "emacsclient -c -a 'emacs' --eval '(emms)' --eval '(emms-play-directory-tree \"~/Music/\")'";
      gaa = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend -m";
      gpl = "git pull";
      gph = "git push";
      gco = "git checkout";
      gst = "git status";
      glog = "git log --pretty=format:'%C(auto)%h %ad | %C(auto)%s%d %Cblue(%an)' --graph --date=format:'%Y-%m-%d %H:%M:%S[%z]'";
    };
    plugins = [
      {
        name = "doas";
        src = pkgs.fetchFromGitHub {
          owner = "monesonn";
          repo = "doas.zsh";
          rev = "11ead2969f7466439351e18f1059a8c1abeb244d";
          sha256 = "1fz1h3kq7ch9slk534vyxkjilvyag83xp2049rk1crngh6ia2hhm";
        };
      }
    ];
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.config/zsh/history";
    };
#    oh-my-zsh = {
#      enable = true;
#      #custom = "PATH";
#      plugins = [ "git" ];
#      #theme = "agnoster";
#      extraConfig = ''
#      '';
#    };
  };
}

