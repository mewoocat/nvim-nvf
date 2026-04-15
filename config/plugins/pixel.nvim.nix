{pkgs, ...}: {
  vim = {
    options = {
      termguicolors = false;
    };
    extraPlugins = {   
        pixel = {
          package = pkgs.vimUtils.buildVimPlugin {
            pname = "pixel.nvim"; version = "";
            src = builtins.fetchGit {
              #url = "https://github.com/bjarneo/pixel.nvim.git";
              url = "https://github.com/mewoocat/pixel.nvim.git";
              ref = "main";
              #rev = "fd06541f7c790e22ad18f0ee5873b246de5b4a87";
              rev = "6ca8976caf949dc1767bf9b31ff0128aa642248b";
            };
          };
          setup = ''
            vim.cmd.colorscheme("pixel")
          '';
        };
      };
    };
}
