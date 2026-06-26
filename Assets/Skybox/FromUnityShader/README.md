# Skybox / FromUnityShader

外部合并到 Skybox 分类的天空盒资源。

## 来源说明

从 Quake3 引擎资源合并而来，包含 darkskies 天空盒着色器脚本和对应的环境贴图。

## Shader 清单

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `skybox/darkskies/darkskies/darkskies.shader` | `textures/skies/darkskies` | darkskies 天空盒着色器 | ⚠️ **非 Unity Shader 格式** |

## 修复状态说明

- `darkskies.shader` 为 **Quake3 引擎格式**的着色器脚本
- 使用 `q3map_` 系列指令（`q3map_globaltexture`、`q3map_lightsubdivide`、`q3map_surfacelight`、`q3map_sun`）
- 使用 `surfaceparm` 关键字定义表面属性
- **无法在 Unity 中直接作为 Shader 使用**，仅作为资源参考保留
- 该文件无需也无法进行 Unity 兼容性修复

## 附带资源

- `skybox/darkskies/darkskies/` 目录下包含 darkskies 环境贴图（Cube Map 纹理）

## 兼容性说明

- ⚠️ 该 Shader 为 Quake3 格式，Unity 无法识别
- 如需在 Unity 中使用 darkskies 天空盒：
  1. 将 `env/darkskies/` 下的 6 面纹理导入为 Cubemap
  2. 创建 Unity Skybox Material，选择 `Render FX/Skybox` 或 `Skybox/Cubemap` Shader
  3. 将 Cubemap 赋予 Skybox Material
  4. 在 Lighting Settings 中设置 Scene 的 Skybox
