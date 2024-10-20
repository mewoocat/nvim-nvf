{
  description = "My personal nvim config written using nvf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { nixpkgs, nvf, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Configure nvim
    configModule = {
      config.vim = {
        theme.enable = true;
      };
    };

    # Create custom nvim package
    customNeovim = nvf.lib.neovimConfiguration {
      modules = [configModule];
      inherit pkgs;
    };

  in{  
    # Set default flake output to custom nvim package
    # Installing this with `nix profile install` will make `nvim` run using this config
    packages."x86_64-linux".default = customNeovim.neovim;
  };
}
