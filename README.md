# SANSI TikTok Editing Skill

可安装的 Codex Skill，用本地素材自动制作 SANSI 80W RGBW 泛光灯的美国 TikTok Shop 万圣节带货视频。

## 包含内容

- 分镜、遥控器/App互斥、英文文案和CTA规范；
- HDR夜景逐镜头提亮与色彩处理规则；
- 素材打标、历史记录和成片去重规则；
- 自动归档与去重检查 PowerShell 脚本；
- 完整中文剪辑要求与工具安装说明。

## ZIP安装

1. 下载并解压 ZIP。
2. 将整个文件夹放到：

   ```text
   %USERPROFILE%\.codex\skills\installation-tutorial-effect
   ```

3. 重新打开 Codex，或新建一个任务。
4. 使用：

   ```text
   使用 $installation-tutorial-effect，根据我的本地素材制作一条新的美国TikTok Shop英文视频。
   ```

## 从GitHub安装

在另一个 Codex 中发送：

```text
请从这个GitHub仓库安装Skill：<仓库地址>
```

如果环境提供 `skill-installer`，Codex会读取仓库并安装到本地 Skills 目录。

## 必需工具

- FFmpeg和FFprobe；
- PowerShell。

Python 3和Pillow仅用于生成素材联系表，属于推荐项。Video2X、Clipcat和CapCut不是自动剪辑必需工具。

完整说明见 [SANSI-TikTok自动剪辑要求与流程.md](docs/SANSI-TikTok自动剪辑要求与流程.md)。
