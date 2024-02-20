{ pkgs, ... }: {
      # System profile packages
      environment.systemPackages = with pkgs;
      [
        cachix
        ccache
        mpv
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.config.allowUnfree = true;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina

      # Set Git commit hash for darwin-version.
      # system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # enable touch ID for sudo
      security.pam.enableSudoTouchIdAuth = true;
      users.users.kit = {
        name = "kit";
        home = "/Users/kit";
      };
}
