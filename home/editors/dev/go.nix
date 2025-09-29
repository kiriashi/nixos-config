{  
  lib,  
  config,  
  pkgs,  
  ...  
}:  

lib.mkIf config.optional.dev.go {  
  programs.go = {  
    enable = true;  
    # package = pkgs.go_1_25;
    env = {
      GOBIN = "${config.home.homeDirectory}/go/bin";
      GOPATH = "${config.home.homeDirectory}/go";
    };
  };  

  home.packages = with pkgs; [  
    gopls  
    gomodifytags  
    gotests  
    impl  
    go-tools  
    delve  
    golines  
    golangci-lint  
  ];  
}