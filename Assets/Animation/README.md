# Animation — 着色器动画

使用 Shader 实现的动画效果，包括基于深度图的 2D 角色动画、顶点动画和 Q 弹形变。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `DepthMapKitty/Kitty.shader` | `awsl/Kitty` | 基于深度图的 2D Sprite 动画，模拟猫和老鼠片头 3D 狮子效果 | Surface Shader, Blend, 深度图采样 |
| `DepthMapKitty/Sprites-Diffuse.shader` | `Sprites/Diffuse` | Unity 内置 Sprite Diffuse 着色器（配套使用） | Surface Shader, Blend |
| `FishNButterfly/Res/Butterfly.shader` | `Lapu/ButterflyShader` | 蝴蝶扇翅顶点动画，基于 Alpha Cutoff 的翅膀拍打 | Vert/Frag, Alpha Cutoff, 顶点位移 |
| `FishNButterfly/Res/Fish.shader` | `Unlit/FishShader` | 鱼游动顶点动画，基于 Mask 控制身体摆动幅度 | Vert/Frag, 顶点位移, Mask 贴图 |
| `Qspring/Qspring_2D.shader` | `Lapu/Qspring_2D` | 2D Q 弹果冻效果，点击位置产生弹性波纹 | Vert/Frag, Blend, 波纹计算 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `DepthMapKitty/` | 基于深度图的 2D 动画系统 |
| `FishNButterfly/` | 鱼和蝴蝶的顶点动画 |
| `Qspring/` | Q 弹果冻效果 |
| `FromUnityShader/` | 外部合并的动画着色器资源（详见子目录 README） |

## 兼容性说明

- 所有 Shader 使用 CGPROGRAM，兼容 Built-in Render Pipeline
- `Kitty.shader` 基于 Unity 内置 Sprite Shader 修改，依赖 `_MainTex` 和深度图
- `Fish.shader` 和 `Butterfly.shader` 需要 SM 3.0+ 支持
