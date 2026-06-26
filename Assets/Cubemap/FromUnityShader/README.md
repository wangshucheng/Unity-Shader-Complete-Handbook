# Cubemap / FromUnityShader

外部合并到 Cubemap 分类的着色器资源。

## 来源说明

从外部 Unity Shader 教程/项目合并而来，包含简单 Cubemap 反射示例。

## Shader 清单

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `reflect/SimpleReflection.shader` | `Custom/SimpleReflection` | 使用 Cubemap 实现简单环境反射 | ✅ 已修复：无已知问题 |

## 附带文件

| 文件 | 说明 |
|------|------|
| `reflect/d_cubMap.cs` | C# 脚本，用于运行时渲染/设置 Cubemap |

## 修复状态说明

- `SimpleReflection.shader` 为 Surface Shader + Standard 光照，代码兼容性良好
- 已清理 `.meta.meta` 重复文件

## 兼容性说明

- Surface Shader 实现，兼容 Built-in Render Pipeline
- 需要提供 Cubemap 纹理资源
