# Lighting / FromUnityShader

外部合并到 Lighting 分类的光照模型示例着色器。

## 来源说明

来自教材配套的光照示例代码，包含顶点级和像素级漫反射 Surface Shader 实现。

## Shader 清单

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `book/1.5/DiffuseVertex.shader` | `Custom/DiffuseVertex` | 顶点漫反射（Surface Shader 版） | ✅ 已修复：无已知问题 |
| `book/2/DiffusePixel.shader` | `Custom/DiffusePixel` | 像素漫反射（Surface Shader 版） | ✅ 已修复：无已知问题 |

## 修复状态说明

- 两个 Shader 为 Surface Shader + Standard 光照实现，代码兼容性良好
- 已清理 `.meta.meta` 重复文件

## 兼容性说明

- Surface Shader 实现，兼容 Built-in Render Pipeline
- 与 `Lighting/Diffuse/` 下的 Vert/Frag 版本形成对照（同一光照模型的不同实现方式）
