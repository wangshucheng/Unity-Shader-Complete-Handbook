# Effect — 视觉特效

项目最大的分类，包含 48 个 Shader，涵盖描边、水面、溶解、模糊、科幻特效等各类视觉效果。

## Shader 清单

### 描边类

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `2D_Outline/Res/Shader/Outline.shader` | `MyShader/Effect/Outline` | 2D Sprite 描边效果 | Vert/Frag, Blend, UV 偏移采样 |
| `3D_Outline/Res/Shader/3D_Outline1.shader` | `MyShader/Effect/3D_Outline1` | 3D 模型描边，双 Pass 实现 | Vert/Frag, Cull Front, 顶点沿法线外扩, 深度偏移 |
| `FromUnityShader/outline/outline.shader` | `Custom/toon` | 卡通描边 + 卡通着色 | Vert/Frag, Cull Front, Blend, 色阶量化 |

### 阴影/投影

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `2D_Shadow/Res/Shader/2D_Shadow.shader` | `MyShader/Effect/2D_Shadow` | 2D Sprite 投影效果 | Vert/Frag, Blend, ZTest Always |

### Bloom / 模糊

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Bloom/Res/Shader/BloomEffect.shader` | `Custom/BloomEffect` | 泛光效果，阈值提取高亮 + 模糊叠加 | Vert/Frag, CGINCLUDE, 多 Pass |
| `Blur/Res/Shaders/BlurUI_000.shader` | `Lapu/BlurUI000` | UI 模糊基础版（GrabPass） | Vert/Frag, GrabPass |
| `Blur/Res/Shaders/BlurUI_001.shader` | `Lapu/BlurUI001` | UI 模糊改进版（GrabPass + Blend） | Vert/Frag, GrabPass, Blend |
| `Blur/Res/Shaders/BlurUI_002.shader` | `Lapu/BlurUI002` | UI 模糊高级版 | Vert/Frag, GrabPass, Blend |
| `Blur/Res/Shaders/ScreenBlur_progressive.shader` | `Custom/ScreenBlur_progressive` | 屏幕渐进模糊 | Vert/Frag, CGINCLUDE, 2 Pass |

### 溶解

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Dissolve/Res/Shader/Dissolved.shader` | `MyShader/Effect//Dissolved` | 噪声纹理溶解效果，带边缘颜色 | Vert/Frag, 噪声图采样, alpha 裁剪 |
| `Dissolve2/Resources/dissolve.shader` | `Toon/VerticalDissolve` | 垂直溶解，支持 Toon Ramp 和反向方向 | Surface Shader, 噪声纹理, Toggle 开关 |

### 双纹理

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `DoubleTex/LapuDouble_step1.shader` | `Lapu/LapuDoubleTex_step1` | 单纹理球面点光源效果 | Surface Shader, Standard 光照 |
| `DoubleTex/LapuDouble_step2.shader` | `Lapu/LapuDoubleTex_step2` | 双纹理混合 + 点光源效果 | Surface Shader, Standard 光照, 噪声混合 |

### 热浪 / 遮罩 / 放大镜

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `HeatWave/Res/Shader/HeatWave.shader` | `MyShader/Effect/HeatWave` | 热浪扭曲效果，基于位移贴图 | Vert/Frag, Blend, 位移纹理 |
| `Mask/Res/Shader/DarkMaskShader.shader` | `MyShader/DarkMaskShader` | 黑色光圈遮罩效果 | Vert/Frag, ZTest Always, 全屏后处理 |
| `Zoom/Res/Shader/ZoomShader.shader` | `MyShader/Effect/ZoomShader` | 放大镜效果 | Vert/Frag, ZTest Always, UV 缩放 |

### 沙化

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Sand/Res/Shader/SandShader.shader` | `MyShader/SandShader` | 沙化效果，顶点转为粒子飞散 | Vert/Frag, Geometry Shader, SM 4.0 |

### 科幻特效

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Sci-fi/HoloMonitor/HoloMonitor.shader` | `Lapu/HoloMonitor` | 全息显示器效果 | Surface Shader, Standard 光照, 发光 |
| `Sci-fi/Scan/Scan.shader` | `Lapu/Scan` | 扫描线效果，支持世界/本地坐标模式 | Surface Shader, Standard 光照, Toggle 开关 |
| `Sci-fi/Wireframe/Wireframe.shader` | `Lapu/Wireframe` | 线框渲染效果 | Vert/Frag, Geometry Shader, Blend |

### 水面

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Water/Res/Shaders/Water001.shader` | `Lapu/Water001` | 基础卡通水面，波浪顶点动画 | Vert/Frag, 顶点位移 |
| `Water/Res/Shaders/Water002.shader` | `Lapu/Water002` | 带浪花边缘的卡通水面 | Vert/Frag, Blend, 浪花计算 |
| `Water/Res/Shaders/Water003.shader` | `Lapu/Water003` | 带折射扭曲的进阶水面 | Vert/Frag, GrabPass, Blend, 扭曲贴图 |
| `Water/Res/Shaders/blingbling.shader` | `Lapu/blingbling` | 闪烁水面效果 | Vert/Frag, GrabPass, Blend |
| `Water/Res/Shaders/edge_shine.shader` | `Lapu/EdgeShine` | 边缘发光水面 | Vert/Frag, Blend, 扭曲贴图 |
| `WaterSurfaceSimulation/AlfxSurfaceWater.shader` | `Lapu/AlfxWater` | 水面模拟，Flow Map + 法线 + 高光 | Vert/Frag, GrabPass, Blend, Flow Map |

### FromUnityShader 特效

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `FromUnityShader/GodRay/GodRay.shader` | `ZHH/GodRay` | 体积光（God Ray）后处理 | Vert/Frag, 径向采样 |
| `FromUnityShader/GodRay/GodRayOptimize.shader` | `ZHH/GodRayOptimize` | 体积光优化版 | Vert/Frag, 径向采样 |
| `FromUnityShader/GodRay/Blend.shader` | `ZHH/Blend` | 体积光混合 Pass | Vert/Frag |
| `FromUnityShader/GodRay/ReplaceShader.shader` | `ZHH/ReplaceShader` | 替换着色器（固定管线，无 CGPROGRAM） | 固定管线, Color 指令 |
| `FromUnityShader/death/DeathEffect.shader` | `Custom/DeathEffect` | 死亡灰度化效果 | Vert/Frag, 亮度计算 |
| `FromUnityShader/embossment/Embossment.shader` | `Custom/Embossment` | 浮雕效果 | Vert/Frag, Blend, 卷积采样 |
| `FromUnityShader/fluid/FluidEffect.shader` | `Custom/FluidEffect` | 流体纹理滚动效果 | Surface Shader, UV 滚动 |
| `FromUnityShader/fluid/FluidEffect1.shader` | `Custom/FluidEffect1` | 流体效果（PBR 版本） | Surface Shader, Standard 光照 |
| `FromUnityShader/oldFilm/OldFilm.shader` | `Custom/OldFilm` | 老电影效果（暗角、划痕、灰尘） | Vert/Frag, 多纹理混合 |
| `FromUnityShader/sprite/SpriteEffect.shader` | `Custom/SpriteEffect` | 精灵帧动画播放 | Surface Shader, UV 切片 |
| `FromUnityShader/water/WaterRipple.shader` | `Custom/WaterRipple` | 水波纹效果 | Surface Shader, Standard 光照 |
| `FromUnityShader/shader_for_unity-master/...` | 多个 | 皮肤/眼睛/植物/毛发/地形/雪景等高级渲染 | 详见 FromUnityShader README |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `2D_Outline/` | 2D 描边 |
| `2D_Shadow/` | 2D 投影 |
| `3D_Outline/` | 3D 描边 |
| `Bloom/` | 泛光效果 |
| `Blur/` | 模糊效果 |
| `Dissolve/` | 溶解效果 |
| `Dissolve2/` | 垂直溶解 |
| `DoubleTex/` | 双纹理效果 |
| `HeatWave/` | 热浪扭曲 |
| `Mask/` | 遮罩效果 |
| `Sand/` | 沙化效果 |
| `Sci-fi/` | 科幻特效（HoloMonitor、Scan、Wireframe） |
| `Water/` | 水面效果 |
| `WaterSurfaceSimulation/` | 水面模拟 |
| `Zoom/` | 放大镜 |
| `FromUnityShader/` | 外部合并的特效着色器（详见子目录 README） |

## 兼容性说明

- `SandShader.shader` 和 `Wireframe.shader` 使用几何着色器，需要 SM 4.0+
- `ReplaceShader.shader` 为固定管线写法（无 CGPROGRAM），仅作功能说明，不建议用于新项目
- 使用 GrabPass 的 Shader（Blur、Water003、blingbling、AlfxWater）在 URP/HDRP 下不兼容
