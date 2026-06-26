# PBR — 物理渲染

基于物理的渲染（Physically Based Rendering）实现集合，包括功能完备的手写 PBR、Unity Standard Shader 和基于教程的 PBR 系列着色器。

## Shader 清单

### AlfxPBR — 完整手写 PBR

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `AlfxPBR/AlfxPBR.shader` | `Alfx/AlfxPBR` | 功能完备的手写 PBR：迪士尼漫反射 + NFG 直接高光 + 球谐间接光 + 各向异性 | Vert/Frag, BRDF, 球谐函数, IBL, 各向异性, AlfxPBRLib.cginc |
| `AlfxPBR/AlfxPBRLib.cginc` | — | AlfxPBR 的辅助函数库 | BRDF 计算, 球谐采样, PBR 工具函数 |

### UnityPbrRendering — 教程 PBR 系列

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `UnityPbrRendering/Shaders/My First Shader.shader` | `Custom/My First Shader` | 最简单的 Unlit 着色器 | Vert/Frag, 基础纹理采样 |
| `UnityPbrRendering/Shaders/My First Lighting Shader.shader` | `Custom/My First Lighting Shader` | 基础光照着色器（Tint + Metallic + Smoothness） | Vert/Frag, ForwardBase, 基础 BRDF |
| `UnityPbrRendering/Shaders/Texture Splatting.shader` | `Custom/Texture Splatting` | 纹理混合（Splat Map 控制多纹理混合） | Vert/Frag, 多纹理混合 |
| `UnityPbrRendering/Shaders/Textured With Detail.shader` | `Custom/Textured With Detail` | 带细节纹理的着色器 | Vert/Frag, 双纹理叠加 |
| `UnityPbrRendering/Shaders/ArcFakePbrShader.shader` | `Arc/MyFirstPbr` | 简化版 PBR（无 LUT） | Vert/Frag, ForwardBase, 基础 BRDF |
| `UnityPbrRendering/Shaders/ArcHandWritePbr.shader` | `Arc/ArcHandWritePbr` | 手写 PBR + LUT 查找表 | Vert/Frag, ForwardBase, LUT 纹理 |
| `UnityPbrRendering/Shaders/ArcHandWritePbrExp.shader` | `Arc/ArcHandWritePbrExp` | 手写 PBR 实验版 | Vert/Frag, ForwardBase, LUT 纹理 |
| `UnityPbrRendering/unity pbr/Height2.shader` | `Unlit/Height2` | 视差/高度映射着色器 | Vert/Frag, 高度图, 视差遮蔽 |

### 根目录 PBR

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Standard.shader` | `Standard` | Unity 内置 Standard Shader 源码 | Vert/Frag, 2 Pass, Blend, 完整 PBR |
| `ArcHandWritePbrTexture.shader` | `Arc/ArcHandWritePbr` | 手写 PBR + 法线贴图 + 金属度贴图 | Vert/Frag, ForwardBase, LUT, 多贴图 |
| `MyShader_PBRTexture.shader` | `MyShader/PBRTexture` | 另一博主实现的 PBR（粗糙度 + AO） | Vert/Frag, CGINCLUDE, ForwardBase |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `AlfxPBR/` | 功能最完备的手写 PBR（含 cginc 库） |
| `UnityPbrRendering/` | 基于教程的 PBR 学习系列（8 个 Shader） |
| `FromUnityShader/` | 外部合并的 PBR 模型资源（详见子目录 README） |

## 兼容性说明

- `AlfxPBR` 支持调试模式（可单独开关 Diffuse/Specular/SH/Shadow/Detail）
- `Standard.shader` 为 Unity 内置源码，功能最完整但代码复杂
- LUT 查找表需要 BRDF 预计算纹理，运行时通过 `_LUT` 属性传入
- 所有 PBR Shader 使用 `LightMode = ForwardBase`，需要方向光
