{
  pkgs,
  lib,
  config,
  ...
}:

lib.mkIf config.optional.dev.ruby {
  home.packages = with pkgs; [
    ruby
    bundler
  ];

  home.file.".gemrc".text = ''
    ---
    :backtrace: false
    :bulk_threshold: 1000
    :sources:
    - https://gems.ruby-china.com/
    :update_sources: true
    :verbose: true
    install: --no-document
    update: --no-document
  '';
}