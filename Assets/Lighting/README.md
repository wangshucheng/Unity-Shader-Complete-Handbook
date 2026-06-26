# Lighting — 光照模型

基础光照模型实现，包括漫反射（Diffuse）和高光（Specular）的逐顶点和逐像素版本。

## Shader 清单

### Diffuse — 漫反射

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Diffuse/Shaders/Chapter6-DiffuseVertexLevel.shader` | `Unity Shaders Book/Chapter 6/Diffuse Vertex-Level` | 逐顶点漫反射光照 | Vert/Frag, LightMode=ForwardBase, Lighting.cginc |
| `Diffuse/Shaders/Chapter6-DiffusePixelLevel.shader` | `Unity Shaders Book/Chapter 6/Diffuse Pixel-Level` | 逐像素漫反射光照 | Vert/Frag, LightMode=ForwardBase, Lighting.cginc |
| `Diffuse/Shaders/Chapter6-HalfLambert.shader` | `Unity Shaders Book/Chapter 6/Half Lambert` | 半兰伯特光照模型，提升暗部细节 | Vert/Frag, LightMode=ForwardBase, Lighting.cginc |

### Specular — 高光

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Specular/Shaders/Chapter6-SpecularVertexLevel.shader` | `Unity Shaders Book/Chapter 6/Specular Vertex-Level` | 逐顶点 Phong 高光 | Vert/Frag, LightMode=ForwardBase, reflect() |
| `Specular/Shaders/Chapter6-SpecularPixelLevel.shader` | `Unity Shaders Book/Chapter 6/Specular Pixel-Level` | 逐像素 Phong 高光 | Vert/Frag, LightMode=ForwardBase, reflect() |
| `Specular/Shaders/Chapter6-BlinnPhong.shader` | `Unity Shaders Book/Chapter 6/Blinn-Phong` | Blinn-Phong 高光模型 | Vert/Frag, LightMode=ForwardBase |
| `Specular/Shaders/Chapter6-BlinnPhongUseBuildInFunctions.shader` | `Unity Shaders Book/Chapter 6/Blinn-Phong Use Built-in Functions` | 使用 Unity 内置函数的 Blinn-Phong | Vert/Frag, LightMode=ForwardBase, UnityCG.cginc |

### FromUnityShader

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `FromUnityShader/book/1.5/DiffuseVertex.shader` | `Custom/DiffuseVertex` | 顶点漫反射（Surface Shader 版） | Surface Shader, Standard 光照 |
| `FromUnityShader/book/2/DiffusePixel.shader` | `Custom/DiffusePixel` | 像素漫反射（Surface Shader 版） | Surface Shader, Standard 光照, Blend |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `Diffuse/` | 漫反射光照（3 个 Shader） |
| `Specular/` | 高光光照（4 个 Shader） |
| `FromUnityShader/` | 外部合并的光照着色器（详见子目录 README） |

## 兼容性说明

- 所有 Shader 使用 `LightMode = ForwardBase`，需要场景中有方向光
- `Lighting.cginc` 和 `UnityCG.cginc` 为 Built-in Render Pipeline 内置文件
- 半兰伯特模型为非物理光照，仅用于学习参考
