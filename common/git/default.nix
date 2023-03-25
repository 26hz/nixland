{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Hertz Hwang";
    userEmail = "hertz@26hz.com.cn";
    extraConfig = { init = { defaultBranch = "main"; }; };
    delta = {
      enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        } ;
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
    ignores = [ "*~" "*.swp" ];
    signing = {
      #gpgPath = "\${pkgs.gnupg}/bin/gpg2";
      key = "A0F6A25F63CD3D72";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        editor = "nvim";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        #pager = "delta";
      };
      credential = {
        helper = "store";
      };
    };
    aliases = {
      a = "add .";
      b = "branch";
      ba = "branch -a";
      bd = "branch -d";
      bdd = "branch -D";
      br = "branch -r";
      c = "commit";
      ca = "commit -a";
      cm = "commit -m";
      cam = "commit -am";
      cem = "commit --allow-empty -m";
      cd = "commit --amend";
      cad = "commit -a --amend";
      ced = "commit --allow-empty --amend";
      cl = "clone";
      cld = "clone --depth 1";
      clg = "!sh -c 'git clone git://github.com/$1 $(basename $1)' -";
      cp = "cherry-pick";
      cpa = "cherry-pick --abort";
      cpc = "cherry-pick --continue";
      d = "diff";
      dt = "difftool";
      f = "fetch";
      fo = "fetch origin";
      fu = "fetch upstream";
      l = "log --oneline";
      lg = "log --oneline --graph --decorate";
      ls = "ls-files";
      lsf = "!git ls-files | grep -i";
      m = "merge";
      ma = "merge --abort";
      mc = "merge --continue";
      ms = "merge --skip";
      o = "checkout";
      om = "checkout master";
      ob = "checkout -b";
      opr = "!sh -c 'git fo pull/$1/head:pr-$1 && git o pr-$1'";
      pr = "prune -v";
      ps = "push";
      psf = "push -f";
      psu = "push -u";
      pst = "push --tags";
      pso = "push origin";
      psao = "push --all origin";
      psfo = "push -f origin";
      psuo = "push -u origin";
      pl = "pull origin";
      pbo = "pull --rebase origin";
      plom = "pull origin main";
      pbom = "pull --rebase origin main";
      plu = "pull upstream";
      plum = "pull upstream main";
      rb = "rebase";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      rbi = "rebase --interactive";
      re = "reset";
      rh = "reset HEAD";
      reh = "reset --hard";
      rem = "reset --mixed";
      res = "reset --soft";
      rehh = "reset --hard HEAD";
      remh = "reset --mixed HEAD";
      rehom = "reset --hard origin/main";
      r = "remote";
      ra = "remote add";
      rr = "remote rm";
      rv = "remote -v";
      rn = "remote rename";
      rp = "remote prune";
      rs = "remote show";
      rao = "remote add origin";
      rau = "remote add upstream";
      rro = "remote remove origin";
      rru = "remote remove upstream";
      rso = "remote show origin";
      rsu = "remote show upstream";
      rpo = "remote prune origin";
      rpu = "remote prune upstream";
      rmf = "rm -f";
      rmrf  = "rm -rf";
      s = "status";
      sb = "status -sb";
      t = "tag";
      td = "tag -d";
      w = "show";
      wp = "show -p";
      wr = "show -p --no-color";
    };
  };

}
