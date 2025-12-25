{pkgs, ...}: {
  vim = {
    options = {
      termguicolors = false;
    };
    extraPlugins = {   

      # no longer needed
      /*
      fwatch = {
        package = fwatch-nvim;
      };
      */

      # test error
      neopywal = {
        package = pkgs.vimUtils.buildVimPlugin {
          doCheck = false; # skip failing tests
          pname = "neopywal"; version = "";
          src = builtins.fetchGit {
            url = "https://github.com/RedsXDD/neopywal.nvim.git";
            ref = "master";
            # Note that updating to commit df179ff0697301164ec21215d9ab14e20bac18e9 or later
            # will break this setup due to the removal of the use_wallust option
            # See the commit message on df179ff0697301164ec21215d9ab14e20bac18e9 for more details
            rev = "57fb800ccc1c2dd2f6623b82ef3612927a36fd4a";
          };
        };
        setup = ''
          -- Only apply neopywal theme if wallust template is found
          local neopywalPath = vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim"
          local neopywalFile = io.open(neopywalPath, "r")
          if (neopywalFile ~= nil) then
              
              -- Close file handle 
              neopywalFile.close()

              -- Works :)
              local neopywal = require("neopywal")
              neopywal.setup({

                  plugins = {
                      neotree = true,
                      indent_blankline = {
                          enabled = true,
                          colored_indent_levels = false,

                          -- Can either be:
                          --   - A color exported by "get_colors()" (e.g.: `color8`)
                          --   - A hexadecimal color (e.g.: "#ff0000").
                          --   - A function with an optional "C" parameter that returns one of the two options above.
                          --     e.g: function(C) return C.color1 end
                          scope_color = "",
                      }
                  },
                  -- Uses a template file `~/.cache/wallust/colors_neopywal.vim` instead of the
                  -- regular pywal template at `~/.cache/wal/colors-wal.vim`.
                  use_wallust = true,

                  -- This option allows to specify where Neopywal should look for a ".vim" template file
                  -- (e.g.: os.getenv("HOME") .. "/.cache/wal/custom_neopywal_template.vim").
                  colorscheme_file = os.getenv("HOME") .. "/.cache/wallust/colors_neopywal.vim",

                  -- This option allows to use a custom built-in theme palettes like "catppuccin-mocha" or "tokyonight".
                  -- To get the list of available themes take a look at `https://github.com/RedsXDD/neopywal.nvim#Alternative-Palettes`.
                  -- Take note that this option takes precedence over `use_wallust` and `colorscheme_file`.
                  
                  use_palette = "",
                  --use_palette = {
                  --  light = "wallust",
                  --  dark = "wallust",
                  --},

                  -- Sets the background color of certain highlight groups to be transparent.
                  -- Use this when your terminal opacity is < 1.
                  transparent_background = true,

                  -- With this option you can overwrite all the base colors the colorscheme uses.
                  -- For more information take a look at `https://github.com/RedsXDD/neopywal.nvim#Customizing-Colors`
                  custom_colors = {},

                  -- With this option you can overwrite any highlight groups set by the colorscheme.
                  -- For more information take a look at `https://github.com/RedsXDD/neopywal.nvim#Customizing-Highlights`
                  custom_highlights = {},

                  -- Dims the background when another window is focused.
                  dim_inactive = true,

                  -- Apply colorscheme for Neovim's terminal (e.g. `g:terminal_color_0`).
                  terminal_colors = true,

                  -- Shows the '~' characters after the end of buffers.
                  show_end_of_buffer = false,

                  -- Shows the '|' split separator characters.
                  -- It's worth noting that this options works better in conjunction with `dim_inactive`.
                  show_split_lines = true,

                  no_italic = false, -- Force no italic.
                  no_bold = false, -- Force no bold.
                  no_underline = false, -- Force no underline.
                  no_undercurl = false, -- Force no undercurl.
                  no_strikethrough = false, -- Force no strikethrough.

                  -- Handles the styling of certain highlight groups (see `:h highlight-args`).
                  styles = {
                      comments = { "italic" },
                      conditionals = { "italic" },
                      loops = {},
                      functions = {},
                      keywords = {},
                      includes = { "italic" },
                      strings = {},
                      variables = { "italic" },
                      numbers = {},
                      booleans = {},
                      types = { "italic" },
                      operators = {},
                  },

                  -- Setting this to false disables all default file format highlights.
                  -- Useful if you want to enable specific file format options.
                  -- Defaults to false when treesitter is enabled,
                  -- unless manually enabled inside the `setup()` function.
                  default_fileformats = true,

                  -- Setting this to false disables all default plugin highlights.
                  -- Useful if you want to enable specific plugin options.
                  default_plugins = true,

                  -- For more fileformats options please scroll down (https://github.com/RedsXDD/neopywal.nvim#Fileformats)
                  fileformats = {
                      c_cpp = true,
                      c_sharp = true,
                  },

              })

              vim.cmd.colorscheme("neopywal")

              -- Use fwatch to watch for changes in wallust theme
              --local fwatch = require('fwatch')
              --fwatch.watch(vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim", "colorscheme neopywal")

          else
              -- Do nothing right now
          end
        '';
      };
    };
  };
}
