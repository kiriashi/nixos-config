{ config, ... }:
{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      
      settings = {
        # 用户信息
        user = {
          name = config.profile.userName;
          email = config.profile.userEmail;
        };
        
        # 凭证配置
        credential.helper = "store";
        
        # 分支配置
        init.defaultBranch = "main";
        
        # 拉取配置
        pull.rebase = false;
        
        # 性能配置
        feature.manyFiles = true;
        index.skipHash = false;
      };
      
      # 可以添加全局忽略文件
      ignores = [
        "*~"
        "*.swp"
        ".DS_Store"
        "result"
        "result-*"
      ];
    };

    lazygit = {
      enable = true;

      settings = {
        theme.nerdFontsVersion = 3;
        update.method = false;
        disableStartupPopups = true;
      };
    };
  };
}
