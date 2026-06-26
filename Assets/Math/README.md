# Math — 数学工具

着色器相关的数学工具和算法实现，目前包含 Perlin 噪声纹理生成器。

## 内容清单

| 文件路径 | 说明 | 技术要点 |
|----------|------|----------|
| `PerlinNoiseTexture/Scripts/PerlinNoise/PerlinNoise.cs` | Perlin 噪声生成算法 | C# 实现，多维噪声 |
| `PerlinNoiseTexture/Scripts/PerlinNoise/GenerateNoiseMap.cs` | 噪声纹理生成器 | 调用 PerlinNoise 生成 Texture2D |
| `PerlinNoiseTexture/Scripts/PerlinNoise/NoiseMapDisplay.cs` | 噪声纹理显示组件 | 将生成的纹理应用到材质 |
| `PerlinNoiseTexture/Scripts/PerlinNoise/Editor/GenerateNoiseMapEditor.cs` | 编辑器扩展 | 自定义 Inspector 按钮 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `PerlinNoiseTexture/` | Perlin 噪声纹理生成工具（纯 C# 脚本，无 Shader 文件） |

## 技术说明

Perlin 噪声是一种梯度噪声算法，广泛应用于：
- 程序化地形生成
- 溶解/消融特效的噪声图
- 水面波纹模拟
- 云层和雾效

## 兼容性说明

- 纯 C# 实现，不依赖特定渲染管线
- 生成的噪声纹理可用于任意 Shader 的 `_Noise` 属性
