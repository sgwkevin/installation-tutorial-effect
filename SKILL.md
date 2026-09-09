---
name: installation-tutorial-effect
description: Create varied TikTok Shop installation-and-effect product videos from a reusable local footage library. Use when the user asks for “安装教程效果”, wants another video in this saved style, or asks to turn tagged product footage into a new installation/demo selling edit without repeating a previous full sequence.
---

# 安装教程效果

Use `auto-cut` when it is installed. Otherwise run the same storyboard-first workflow locally by creating `segments.json`, `storyboard.json`, `storyboard.md`, `source-manifest.md`, and the QA records described below. This skill is usable on its own.

For the complete SANSI 80W US TikTok project brief, fixed local paths, tool installation notes, title examples, and delivery checklist, read [docs/SANSI-TikTok自动剪辑要求与流程.md](docs/SANSI-TikTok自动剪辑要求与流程.md) before the first edit in a new environment.

## Saved structure

Build the video in this order:

1. Result-first audience hook.
2. Brief before/setup context.
3. Physical installation or placement.
4. One control method demonstrated clearly.
5. Several effect/result shots.
6. Wide final result.
7. CTA positioned for the destination platform UI.

For US TikTok Shop, default to natural American English copy, `1080×1920`, `9:16`, `30 fps`, H.264/AAC, and 15–25 seconds. An explicit user choice overrides these defaults.

## Material tagging and diversity

Before proposing shots, create or update `material-tags.json` beside the storyboard. Read [references/material-schema.md](references/material-schema.md) for the fields. Tag useful time ranges inside a source, not only whole files.

Read or create `usage-history.json`. Individual sources may be reused, but never reproduce a prior final video with the same source/time-range sequence from beginning to end.

Reuse individual shots freely to keep production fast. The only blocking diversity failure is an entire edit whose source files, time ranges, and sequence all exactly match a previously delivered video. Prefer changing one or more of the opening, shot order, time ranges, hook copy, pacing, or closing shot, but do not delay rendering merely to reduce partial overlap.

Run [scripts/check-diversity.ps1](scripts/check-diversity.ps1) against the confirmed storyboard before rendering. After delivery, append the actual sources and time ranges to `usage-history.json`.

## Product and UI constraints

- Show either physical remote control or App control in one finished video, never both, unless the user explicitly asks for both.
- Match the demonstrated control method to the exact SKU.
- Do not show prices, discounts, coupons, wattage, pack quantity, ratings, waterproof grade, or other claims unless confirmed for that video.
- For TikTok Shop, use the saved compact CTA layout instead of a large bottom caption. On a `1080×1920` canvas, place `TAP TO SHOP` at approximately `x=60, y=830`, use a bold font around `54 px`, and put a clear orange downward arrow directly below it around `y=920`. Keep the whole CTA group in the left-middle/lower-middle area shown in the user's reference, well above playback controls. Scale these coordinates proportionally for other canvases.
- Crop out or replace unrelated UI, watermarks, downloaded-video text, and unlicensed reference footage.

## BGM

Use a user-supplied or commercially cleared track. Trim it to the exact final duration, avoid unintended silence, fade only the ending, keep peaks below clipping, and flag uncertain commercial rights.

## Night-footage color handling

- Check iPhone HDR/HLG night footage after conversion to SDR; do not assume the conversion preserves visible shadow detail.
- Grade night footage shot by shot rather than applying one identical correction to every night clip. Review a representative frame from every selected night shot because exposure and subject reflectivity can vary sharply between scenes.
- If faces, decorations, the yard, or the product become hard to see, lift the midtones and shadows and increase color saturation before delivery. For ordinary night footage, use `brightness=0.04`, `gamma=1.10`, and `saturation=1.12` as the starting correction after tone mapping.
- When a very bright floodlight or other highlight is visible but the surroundings remain dark, protect the highlight while lifting the shadows and midtones. Start with `brightness=0.07`, `gamma=1.18`, `saturation=1.15`, and `contrast=1.03`; reduce the correction if the lamp clips or the colors look artificial.
- Prefer a bright, vivid Halloween look with readable red, blue, green, and purple details. Reject or replace severely underexposed shots when correction cannot recover useful detail.
- Do not add a dark overlay anywhere, including the ending. Do not fade the picture to black; keep the final shot at normal brightness and end on the live video frame. A short audio-only fade is allowed.
- When the user explicitly prioritizes completion speed, make one basic correction pass on dark footage and do not rerender solely for aesthetic brightness differences.

## Final QA

In addition to normal `auto-cut` QA, verify:

- no mixed remote/App demonstration;
- no unwanted price information;
- no prior full-sequence duplicate;
- hook and CTA are inside TikTok-safe regions;
- CTA is compact and raised to the saved left-side position; it must not revert to the previous oversized near-bottom layout;
- every selected night shot passes a representative-frame brightness check, especially shots containing a bright lamp against a dark environment; colors must remain vivid after HDR-to-SDR conversion, without crushed shadows or clipped light sources;
- the ending remains a normal-brightness video frame with no black mask, dark overlay, or visual fade-to-black;
- BGM matches the final duration;
- `material-tags.json` and `usage-history.json` reflect the delivered cut.

## Output archive

After the final MP4 passes QA, run [scripts/archive-final.ps1](scripts/archive-final.ps1) to copy it into `D:\视频素材\<M.d>`, using the computer's local date. Create the date folder when missing and reuse it when present. Never overwrite an existing video; append `-v2`, `-v3`, and so on when the filename already exists. Keep the project files in the working project and place the finished MP4 in the dated archive folder.

Deliver the archived MP4 path, storyboard, render script, QA notes, material tags, and usage history.
