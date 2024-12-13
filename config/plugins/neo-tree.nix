{pkgs, ...}: {
  config.vim = {
    extraPlugins = with pkgs.vimPlugins; {   
      neo-tree = {
        package = neo-tree-nvim;
        setup = ''
          vim.keymap.set('n', "<Leader>e", ":Neotree toggle right<cr>")
        '';
      };
    };
  };
}
