# Shadow — 阴影

ShadowMap 阴影技术实现，包括基础 ShadowMap 渲染和带 PCF 软阴影的改进版本。

## Shader 清单

### ShadowMap — 基础版本

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `ShadowMap/Res/Shader/test.shader` | `test` | 基础深度图渲染（将深度输出为纹理） | Vert/Frag, 深度纹理输出 |
| `ShadowMap/Res/Shader/test1.shader` | `test1` | 基础 ShadowMap 阴影接收 | Vert/Frag, 深度比较 |

### ShadowMap2 — 改进版本

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `ShadowMap2/Shader/DepthTextureShader.shader` | `ShadowMap/DepthTextureShader` | 深度纹理渲染（ShadowMap 生成） | Vert/Frag, 深度输出 |
| `ShadowMap2/Shader/ShadowMapNormal.shader` | `Shadow/ShadowMapNormal` | 基础 ShadowMap 阴影接收 | Vert/Frag, 深度比较 |
| `ShadowMap2/Shader/ShadowMapNormalWithBias.shader` | `Shadow/ShadowMapNormalWithBias` | 带 Bias 的 ShadowMap 阴影接收 | Vert/Frag, Bias 偏移 |
| `ShadowMap2/Shader/ShadowMapWithPCF.shader` | `Shadow/ShadowMapWithPCF` | PCF 软阴影（百分比渐进滤波） | Vert/Frag, PCF 采样 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `ShadowMap/` | 基础 ShadowMap（2 个 Shader） |
| `ShadowMap2/` | 改进版 ShadowMap（4 个 Shader，含 PCF 和 Bias） |

## 技术说明

ShadowMap 工作流程：
1. **生成阶段：** 从光源视角渲染场景深度到纹理（`DepthTextureShader`）
2. **接收阶段：** 在主相机渲染时，将顶点变换到光源空间，比较深度值判断是否被遮挡
3. **PCF 软阴影：** 对阴影边缘进行多次采样模糊，消除锯齿

## 兼容性说明

- 所有 Shader 使用 CGPROGRAM，兼容 Built-in Render Pipeline
- 需要配合 C# 脚本设置光源相机和 RenderTexture
- PCF 采样数越多性能开销越大
