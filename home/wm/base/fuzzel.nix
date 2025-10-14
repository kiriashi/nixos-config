{
  lib,
  ...
}:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=11";
        icons-enabled = "yes";
        layer = "overlay";
        line-height = "16";
        terminal = "kitty";
      };
      colors = {
        background = "#2c2c2ce6";

        text = "#ffffffff";
        prompt = "#4db6acff";
        input = "#4db6acff";
        match = "#f3777cff";

        selection = "#383838cc";
        selection-text = "#8fc3a2ff";
        selection-match = "#f58e92ff";

        border = "#85c7d5ff";
      };
      border = {
        width = "4";
        radius = "12";
      };
    };
  };
}
