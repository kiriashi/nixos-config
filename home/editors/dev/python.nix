{
  pkgs,
  lib,
  config,
  ...
}:

lib.mkIf config.optional.dev.python {
  home.packages = with pkgs; [
    python3
  ];

  home.file.".pip/pip.conf".text = ''
    [global]
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
    trusted-host = pypi.tuna.tsinghua.edu.cn
    timeout = 60
  '';
}