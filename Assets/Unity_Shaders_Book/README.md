# Unity_Shaders_Book — 《Unity Shader 入门精要》配套着色器

冯乐乐《Unity Shader 入门精要》一书的配套 Shader 示例，涵盖第 11/13/15 章的进阶效果。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Shaders/Chapter11/Chapter11-Water.shader` | `Unity Shaders Book/Chapter 11/Water` | 水面扭曲效果（顶点动画 + 流动 UV） | Vert/Frag, Blend, Cull Off, 顶点位移 |
| `Shaders/Chapter13/Chapter13-EdgeDetectNormalAndDepth.shader` | `Unity Shaders Book/Chapter 13/Edge Detection Normals And Depth` | 基于法线和深度的边缘检测 | Vert/Frag, CGINCLUDE, 深度+法线纹理 |
| `Shaders/Chapter13/Chapter13-FogWithDepthTexture.shader` | `Unity Shaders Book/Chapter 13/Fog With Depth Texture` | 基于深度纹理的全局雾效 | Vert/Frag, CGINCLUDE, _CameraDepthTexture |
| `Shaders/Chapter13/Chapter13-MotionBlurWithDepthTexture.shader` | `Unity Shaders Book/Chapter 13/Motion Blur With Depth Texture` | 基于深度纹理的运动模糊 | Vert/Frag, CGINCLUDE, 视图矩阵重建世界坐标 |
| `Shaders/Chapter15/Chapter15-FogWithNoise.shader` | `Unity Shaders Book/Chapter 15/Fog With Noise` | 带噪声纹理的全局雾效 | Vert/Frag, CGINCLUDE, 噪声纹理, 深度纹理 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `Shaders/Chapter11/` | 第 11 章：水面效果 |
| `Shaders/Chapter13/` | 第 13 章：基于深度纹理的边缘检测/雾效/运动模糊 |
| `Shaders/Chapter15/` | 第 15 章：噪声雾效 |

## 技术说明

- **第 11 章** 水面效果使用顶点动画实现波浪，配合 UV 流动和透明混合
- **第 13 章** 三个 Shader 都使用 `_CameraDepthTexture`，需要相机开启深度纹理渲染
  - 雾效使用 `_FrustumCornersRay` 通过深度反推世界坐标
  - 运动模糊通过当前帧和上一帧视图投影矩阵差异计算速度
- **第 15 章** 在第 13 章雾效基础上增加噪声纹理扰动，实现更自然的雾效

## 兼容性说明

- 所有 Shader 使用 CGPROGRAM，兼容 Built-in Render Pipeline
- 第 13/15 章 Shader 需要相机开启 `Depth Texture` 模式
- `Chapter13-MotionBlurWithDepthTexture` 需要脚本传递 `_PreviousViewProjectionMatrix`
- `Chapter11-Water` 使用 `DisableBatching = True`，因顶点动画不支持批处理
