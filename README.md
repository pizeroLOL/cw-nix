# cw-nix

简单把 [Class Widgets](https://github.com/Class-Widgets/Class-Widgets) 打包到 nix

## 食用方法

开始 `nix-command` 和 `flakes`，随后执行以下命令

```bash
nix run github:pizeroLOL/cw-nix#
```

## 已知问题

- 在 QT_QPA_PLATFORM=xcb 环境变量下设置闪退（修复中）
- wayland 下显示不正常（特性，没法修）
