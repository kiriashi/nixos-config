{
  pkgs, 
  ... 
}:
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      languagePacks = [ "zh-CN" ];
      nativeMessagingHosts = with pkgs; [
        keepassxc
      ];

      extraEnvVars = {
        MOZ_ENABLE_WAYLAND = "1";
      };

      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;

        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = false;
        DefaultDownloadDirectory = "\${home}/Downloads";

        # EnableTrackingProtection = {
        #   Value = true;
        #   Locked = true;
        #   Cryptomining = true;
        #   Fingerprinting = true;
        # };

        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        PromptForDownloadLocation = false;

        RequestedLocales = [ "zh-CN" ];
        SanitizeOnShutdown = {
          Cache = true;
          Cookies = false;
          FormData = false;
          History = false;
          Sessions = false;
          SiteSettings = false;
          Locked = true;
        };
        SearchEngines_Default = "Bing";
      };
    };
  };
}