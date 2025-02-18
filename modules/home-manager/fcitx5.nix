{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # home.file = {
  #   ".config/fcitx5".source = ../../xdg/config/fcitx5;
  #   ".local/share/fcitx5" = {
  #     source = ../../xdg/data/fcitx5;
  #     recursive = true;
  #   };
  # };
  # fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-nord
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-minecraft
    ];
  };
}
