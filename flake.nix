{
  description = "My personal nvim config written using nvf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    plugin-neopywal = {
      url = "github:RedsXDD/neopywal.nvim";
      flake = false;
    };
  };

  outputs = { nixpkgs, nvf, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    #configModule = import ./config/general.nix {inherit pkgs;};

    # Create custom nvim package
    customNeovim = nvf.lib.neovimConfiguration {
      modules = [
        ./config
      ];
      inherit pkgs;
    };

  in{  
    # Set default flake output to custom nvim package
    # This package is a wrapped version of the nvim package
    packages."x86_64-linux".default = customNeovim.neovim;
  };
}
