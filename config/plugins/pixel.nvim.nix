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
              url = "https://github.com/bjarneo/pixel.nvim.git";
              ref = "main";
              rev = "fd06541f7c790e22ad18f0ee5873b246de5b4a87";
            };
          };
          setup = ''
            vim.cmd.colorscheme("pixel")
          '';
        };
      };
    };
}
