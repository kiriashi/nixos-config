{ ... }:

{
  imports = [ ./default.nix ];

  profile = {
    editor = "hx";
    font = "Maple Mono NF CN";
    darkMode = false;
    browser = "firefox";
  };

  optional = {
    wm = true;

    hypr = false;

    niri = true;

    doas = true;

    vir = true;

    dev = {
      helix = true;
      zed = true;
      vscode = true;

      go = true;
      rust = true;
      node = true;
      python = true;
      java = true;
    };
  };
  
}