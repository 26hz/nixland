{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      nord-vim
      nerdtree
      yankring
      vim-nix {
        plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }
      markdown-preview-nvim
    ];
    extraConfig = ''
      let mapleader=" "
      set nocompatible
      filetype on
      filetype indent on
      filetype plugin on
      filetype plugin indent on
      syntax on
      set clipboard=unnamed
      set mouse-=nvi
      set encoding=utf-8
      set backspace=indent,eol,start
      set autochdir
      set nu
      set norelativenumber
      set cursorline
      set wrap
      set showcmd
      set wildmenu
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      exec "nohlsearch"
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

      noremap <LEADER><CR> :nohlsearch<CR>
      noremap <LEADER>n :normal
      nnoremap <LEADER>t :NERDTreeFocus<CR>
      nnoremap <C-n> :NERDTree<CR>
      nnoremap <C-t> :NERDTreeToggle<CR>
      nnoremap <C-f> :NERDTreeFind<CR>

      vmap <LEADER>y "+y
      vmap <LEADER>d "+d
      nmap <LEADER>p "+p
      vmap <LEADER>p "+p

      map s <nop>
      map R :w<CR>:source ~/.config/nvim/init.vim<CR>
      map W :w<CR>
      map Q :q<CR>
      map S :set nonumber<CR>

      map sh :set nosplitright<CR>:vsplit<CR>
      map sj :set splitbelow<CR>:split<CR>
      map sk :set nosplitbelow<CR>:split<CR>
      map sl :set splitright<CR>:vsplit<CR>
      map <LEADER>h <C-w>h
      map <LEADER>j <C-w>j
      map <LEADER>k <C-w>k
      map <LEADER>l <C-w>l

      map tk :tabe<CR>
      map th :-tabnext<CR>
      map tl :+tabnext<CR>

      colorscheme nord
      autocmd VimEnter * NERDTree | wincmd p
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    '';
  };

}
