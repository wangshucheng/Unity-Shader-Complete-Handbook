# Base — 基础着色器

着色器开发的基础组件，目前包含深度纹理渲染。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `DepthTexture/Res/Shader/DepthTexture.shader` | `MyShader/Base/DepthTexture` | 将场景深度渲染为纹理，供阴影、雾效等后处理使用 | Vert/Frag, 深度纹理输出 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `DepthTexture/` | 深度纹理渲染工具 |

## 兼容性说明

- 使用 `UnityCG.cginc`，兼容 Built-in Render Pipeline
- 需要 SM 3.0+
- 输出的深度纹理可被 Shadow、PostProcessing 等分类使用
