# originally derived from https://sandstorm.de/de/blog/post/my-first-steps-with-nix-on-mac-osx-as-homebrew-replacement.html
{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs";
        neovim-flake = {
            url = "github:neovim/neovim?dir=contrib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, neovim-flake }: {
        packages."aarch64-darwin".default = let
            pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        in pkgs.buildEnv {
            name = "home-packages";
            paths = with pkgs; [
                # 00 cli tools
                curl
                fastfetch
                ffmpeg
                fzf
                git
                gnupg
                jq
                lnav
                tmux
                trivy

                # web
                httpie
                caddy

                # package management
                pipx
                yarn

                # storage
                duckdb
                sqlite

                # languages
                tree-sitter
                racket
                zig

                # containers
                dive


                # media
                mpv
                yt-dlp

                neovim-flake.packages.aarch64-darwin.neovim
            ];
        };
    };

}
