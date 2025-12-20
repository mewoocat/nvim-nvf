{pkgs, ...}: {
  extraPlugins = {   

    # Doesn't seem to have any effect, might be worth investigating as a replacement to neopywal
    pixel = {
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "pixel.nvim"; version = "";
        src = builtins.fetchGit {
          url = "https://github.com/bjarneo/pixel.nvim.git";
          ref = "main";
          rev = "11f800e8253fdb079f9de66c10ebdfec95782891";
        };
      };
      setup = ''
        vim.cmd.colorscheme("pixel")
      '';
    };
  };
}
