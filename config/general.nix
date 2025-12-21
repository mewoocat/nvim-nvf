{pkgs, lib, ...}: {
# Configure nvim
  config.vim = {
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;

    autocmds = [
      {
        desc = "Sets default indent";
        event = ["BufEnter"];
        pattern = null;
        callback = lib.generators.mkLuaInline ''
          function()
            vim.opt.tabstop = 2
            vim.opt.expandtab = true
            vim.opt.softtabstop = 2
            vim.opt.shiftwidth = 2
          end
        '';
        once = true;
      }
      {
        desc = "Sets indent for nix files";
        event = ["BufEnter"];
        pattern = [
          "*.nix"
          "*.md"
        ];
        callback = lib.generators.mkLuaInline ''
          function()
            vim.opt.tabstop = 4
            vim.opt.expandtab = true
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
          end
        '';
        once = true;
      }
    ];

    binds = {
      # Keybind helper & cheatsheet
      whichKey = {
        enable = true;
      };
    };

    dashboard = {
      alpha = {
        enable = true;
      };
    };

    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };

    diagnostics = {

    };

    treesitter = {
      grammars = with pkgs; [
        vimPlugins.nvim-treesitter-parsers.qmljs
      ];
    };

    visuals = {
      indent-blankline.enable = true;
      nvim-web-devicons.enable = true;
    };

    theme = {
      enable = false;
      name = "oxocarbon";
      style = "dark";
    };

    lsp = {
      enable = true;
      lspSignature.enable = true;
      lspconfig.enable = true;
      inlayHints.enable = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      nvim-docs-view.enable = true;
    }; 

    minimap = {
      codewindow.enable = true; # <leader>mm toggles
    };

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      clang.enable = true; # C/C++
      ts.enable = true; # JS/TS
      markdown.enable = true;
      html.enable = true;
      lua.enable = true;
      bash.enable = true;
      css.enable = true;
      elixir.enable = true;
      csharp.enable = true;
      json.enable = true;
      qml.enable = true;
      yaml.enable = true;
    };

    clipboard = {
      enable = true;
      providers = {
        wl-copy.enable = true;
      };
      registers = "unnamedplus"; # To Always use the system clipboard
    };
    
    globals = {
      mapLeader = " "; # Set leader to space
    };

    hideSearchHighlight = true;
    lineNumberMode = "relative";
    searchCase = "ignore";
    spellcheck.enable = true;
    syntaxHighlighting = true; # investigate

    statusline = {
      lualine = {
        enable = true;
      };
    };

    telescope = {
      enable = true;
      setupOpts = {
        pickers = {
          buffers = {
            sort_lastused = true;
            sort_mru = true;
            ignore_current_buffer = true;
          };
        };
        defaults = {
          color_devicons = true;
        };
      };
      extensions = [
        {
          name = "fzf";
          packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
          setup = {
            fzf = {
              fuzzy = true;
            };
          };
        }
      ];
    };

    filetree = {
      neo-tree = {
        enable = true;
        setupOpts = {
          close_if_last_window = true;
        };
      };
    };

    # Key mapping
    maps = {
      normal = {
          "<leader>e".action =":Neotree toggle right<cr>"; # Note the ":" is used to invoke the command
      };
    };
    # There's also vim.keymaps
    /*
    vim.keymaps = [
    {
      key = "<leader>m";
      mode = "n";
      silent = true;
      action = ":make<CR>";
    }
    */

    git = {
      enable = true;
    };

    options = {
      # Set indent size
      shiftwidth = 2; # Number of spaces inserted when indenting
      tabstop = 2; # A TAB character looks like 2 spaces
      softtabstop = 2; # Number of spaces inserted instead of a TAB character
      expandtab = true; # Pressing the TAB key will insert spaces instead of a TAB character

      wrap = false;

      termguicolors = false;
    };

    ui = {
      borders.globalStyle = "rounded";
      breadcrumbs.enable = true;
      illuminate.enable = true;
    };

    presence = {
      neocord.enable = true;
    };

    #startPlugins = ["neopywal"];
    luaConfigRC = {
      globalsScript = ''
        --vim.g.mapleader = " " -- Set leader to space
      '';
      optionsScript = ''
        --vim.opt.wrap = false
        --vim.opt.clipboard = "unnamedplus" -- External clipboard support
        --vim.opt.number = true
        --vim.opt.laststatus = 0 -- Never show status line
        --vim.opt.relativenumber = true
        --vim.opt.mouse = ""

        -- Tab config
        --vim.opt.tabstop = 4 -- A TAB character looks like 2 spaces
        --vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
        --vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
        --vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting

        -- QML lsp setup
        vim.lsp.config['qmlls'] = {
          cmd = {"${pkgs.qt6.qtdeclarative}/bin/qmlls", "-E"}
        }
      '';
    };

    extraPlugins = with pkgs.vimPlugins; {   
      web-devicons = {
        package = nvim-web-devicons;
        setup = '''';
      };
    };
  };
}
