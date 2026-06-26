# Skybox — 天空盒

天空盒和环境着色器资源。

## 内容

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `FromUnityShader/skybox/darkskies/darkskies/darkskies.shader` | `textures/skies/darkskies` | darkskies 天空盒着色器 | **Quake3 格式**，非 Unity Shader |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `FromUnityShader/` | 外部合并的天空盒资源（详见子目录 README） |

## 兼容性说明

- ⚠️ `darkskies.shader` 为 **Quake3 引擎格式**的着色器脚本，使用 `q3map_` 系列指令和 `surfaceparm` 关键字，**不是 Unity 原生 Shader**
- 该文件无法在 Unity 中直接作为 Shader 使用，仅作为资源参考保留
- 如需在 Unity 中使用 darkskies 天空盒，应将 `env/darkskies/` 下的 Cubemap 纹理设置为 Unity Skybox Material
