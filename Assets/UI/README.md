# UI — UI 着色器

UI 相关的 Shader，目前包含毛玻璃（Blur）效果实现。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `UI毛玻璃shader/UIBlur/Shader/UIBlur.shader` | `Custom/UIBlur` | UI 毛玻璃模糊，支持 Alpha Mask 和 Stencil 遮罩 | Vert/Frag, Stencil, Blend, Toggle 开关 |
| `UI毛玻璃shader/UIBlur/Shader/UIBlurPostEffect.shader` | `Custom/UIBlurPostEffect` | UI 毛玻璃后处理版 | Vert/Frag, 全屏后处理 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `UI毛玻璃shader/` | UI 毛玻璃 Shader 资源 |

## 兼容性说明

- `UIBlur.shader` 支持 Stencil 遮罩，可控制模糊区域
- `UIBlurPostEffect.shader` 为全屏后处理版，适合背景整体模糊
- 使用 Blend 混合模式，不兼容 URP/HDRP 原生 UI 系统
- UI 渲染队列为 `Transparent`，需配合 Canvas 设置
