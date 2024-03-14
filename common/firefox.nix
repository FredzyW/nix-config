{ pkgs, lib, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      userChrome = ''
        @import "${
            builtins.fetchGit {
                url = "https://github.com/rockofox/firefox-minima";
                ref = "main";
                rev = "c5580fd04e9b198320f79d441c78a641517d7af5"; # <-- Change this
            }
          }/userChrome.css";
          '';
      settings = {
          # Enable userChrome customizations
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   (lib.mkIf config._1password.enable onepassword-password-manager)
      #   pkgs.bypass-paywalls-clean
      #   # darkreader
      #   facebook-container
      #   markdownload
      #   ublock-origin
      #   vimium
      #   bitwarden
      # ];
    };
  };
}
