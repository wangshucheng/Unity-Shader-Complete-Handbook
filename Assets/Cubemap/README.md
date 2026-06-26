# Cubemap — 立方体贴图

使用 Cubemap 实现环境反射和折射效果，包含运行时渲染 Cubemap 的编辑器工具。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Reflection/Res/Shader/Reflection.shader` | `MyShader/Cubemap/Reflection` | Cubemap 环境反射，支持反射颜色和反射强度控制 | Vert/Frag, multi_compile_fwdbase, Cubemap 采样 |
| `Refraction/Res/Shader/Refraction.shader` | `MyShader/Cubemap/Refraction` | Cubemap 环境折射，支持折射率控制 | Vert/Frag, multi_compile_fwdbase, refract() 函数 |
| `FromUnityShader/reflect/SimpleReflection.shader` | `Custom/SimpleReflection` | 简单 Cubemap 反射（Surface Shader 实现） | Surface Shader, Standard 光照, Cubemap 采样 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `Reflection/` | Cubemap 反射效果 |
| `Refraction/` | Cubemap 折射效果 |
| `RenderCubemap/` | 运行时渲染 Cubemap 的编辑器工具（C# 脚本） |
| `FromUnityShader/` | 外部合并的 Cubemap 着色器（详见子目录 README） |

## 兼容性说明

- 所有 Shader 使用 CGPROGRAM，兼容 Built-in Render Pipeline
- `Reflection` 和 `Refraction` 使用 `LightMode = ForwardBase`，需要场景中有方向光
- `RenderCubemap` 为编辑器扩展脚本，通过 `Editor` 目录下的 C# 脚本调用
