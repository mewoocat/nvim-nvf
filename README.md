My nvim config

# Overview
---
- Packaged as a Nix Flake
- Made using nvf https://github.com/NotAShelf/nvf


# Installation 
---

### NixOS Flake
Add this repo to the flake inputs,
```
inputs = {
    ...
    myNvim.url = "github:mewoocat/nvim-nvf";
    ...
};
```
Then add `inputs.myNvim.packages.x86_64-linux.default` to your packages

### Nix Profile
TODO

# Usage
```bash
nvim
```
