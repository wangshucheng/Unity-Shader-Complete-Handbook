# UnityShaderComplete

Unity Shader 完全手册 —— 涵盖动画、光照、PBR、后处理、几何着色器、阴影等 17 个分类的 130 个 Shader 文件，是学习和参考 Unity 内置管线着色器编写的完整合集。

## 项目结构

```
Assets/
├── Animation/              # 着色器动画（顶点动画、果冻弹跳、精灵动画）
│   ├── DepthMapKitty/      # 基于深度图的 2D 动画
│   ├── FishNButterfly/     # 鱼游动 & 蝴蝶扇翅顶点动画
│   ├── Qspring/            # Q 弹果冻效果
│   └── FromUnityShader/    # 外部合并的动画着色器
├── Base/                   # 基础着色器（深度纹理）
│   └── DepthTexture/       # 深度图渲染
├── Cubemap/                # 立方体贴图（反射、折射、渲染 Cubemap）
│   ├── Reflection/         # Cubemap 反射
│   ├── Refraction/         # Cubemap 折射
│   ├── RenderCubemap/      # 运行时渲染 Cubemap 的编辑器工具
│   └── FromUnityShader/    # 外部合并的 Cubemap 着色器
├── Effect/                 # 视觉特效（描边、水面、溶解、模糊、科幻等）
│   ├── 2D_Outline/         # 2D 描边
│   ├── 2D_Shadow/          # 2D 投影
│   ├── 3D_Outline/         # 3D 描边
│   ├── Bloom/              # 泛光效果
│   ├── Blur/               # 模糊（GrabPass、屏幕模糊）
│   ├── Dissolve/           # 溶解效果
│   ├── Dissolve2/          # 垂直溶解
│   ├── DoubleTex/          # 双纹理点光源效果
│   ├── HeatWave/           # 热浪扭曲
│   ├── Mask/               # 黑色光圈遮罩
│   ├── Sand/               # 沙化效果（几何着色器）
│   ├── Sci-fi/             # 科幻特效（全息屏幕、扫描、线框）
│   ├── Water/              # 卡通水面（多版本）
│   ├── WaterSurfaceSimulation/  # 水面模拟（Flow Map）
│   ├── Zoom/               # 放大镜效果
│   └── FromUnityShader/    # 外部合并的特效着色器
├── GeometryShader/         # 几何着色器（示例、草地渲染）
│   ├── Example/            # 几何着色器基础示例
│   ├── Grass/              # 草地渲染（几何+曲面细分）
│   └── FromUnityShader/    # 外部合并的几何着色器
├── GpuInstance/            # GPU 实例化（MaterialPropertyBlock）
├── Lighting/               # 光照模型（漫反射、高光）
│   ├── Diffuse/            # 逐顶点/逐像素漫反射、半兰伯特
│   ├── Specular/           # Phong、Blinn-Phong 高光
│   └── FromUnityShader/    # 外部合并的光照着色器
├── Math/                   # 数学工具（Perlin 噪声纹理生成）
├── Other/                  # 其他（共享模型资源）
│   └── FromUnityShader/    # 外部合并的杂项资源
├── PBR/                    # 物理渲染（手写 PBR、Unity Standard）
│   ├── AlfxPBR/            # 功能完备的手写 PBR
│   ├── UnityPbrRendering/  # 参考教程手写 PBR 系列
│   └── FromUnityShader/    # 外部合并的 PBR 示例资源
├── PostProcessing/         # 后处理（Bloom、模糊、边缘检测、运动模糊等）
│   ├── Shaders/            # 《Unity Shader 入门精要》第 12 章后处理
│   └── FromUnityShader/    # 外部合并的后处理着色器
├── ScreenSpace/            # 屏幕空间效果
│   └── ScreenSpaceReflection/  # 屏幕空间反射（SSR）
├── Shadow/                 # 阴影
│   ├── ShadowMap/          # 基础 ShadowMap
│   └── ShadowMap2/         # 改进版（PCF、Bias）
├── Skybox/                 # 天空盒
│   └── FromUnityShader/    # 外部合并的天空盒着色器
├── UI/                     # UI 着色器
│   └── UI毛玻璃shader/     # UI 毛玻璃模糊
├── Unity_Shaders_Book/     # 《Unity Shader 入门精要》配套着色器
│   └── Shaders/            # 第 11/13/15 章示例
└── SurfaceShader.shader    # Surface Shader 示例（Cubemap 反射）
```

## 分类总览

| 分类 | Shader 数 | 说明 |
|------|-----------|------|
| Animation | 5 | 着色器动画：顶点位移、深度图动画、Q 弹效果 |
| Base | 1 | 基础：深度纹理渲染 |
| Cubemap | 3 | 立方体贴图：反射、折射、简单反射 |
| Effect | 48 | 视觉特效：描边、水面、溶解、模糊、科幻等 |
| GeometryShader | 8 | 几何着色器：基础示例、草地渲染、曲面细分 |
| GpuInstance | 1 | GPU 实例化：MaterialPropertyBlock |
| Lighting | 9 | 光照模型：漫反射、半兰伯特、Phong、Blinn-Phong |
| Math | 0 | 数学工具：Perlin 噪声纹理生成（C# 脚本） |
| Other | 0 | 其他：共享模型资源（无 Shader） |
| PBR | 12 | 物理渲染：手写 PBR、Unity Standard、BRDF |
| PostProcessing | 27 | 后处理：Bloom、高斯模糊、边缘检测、运动模糊等 |
| ScreenSpace | 1 | 屏幕空间反射（SSR） |
| Shadow | 6 | 阴影：ShadowMap、PCF、Bias |
| Skybox | 1 | 天空盒（Quake3 格式，非 Unity Shader） |
| UI | 2 | UI 着色器：毛玻璃模糊 |
| Unity_Shaders_Book | 5 | 《Unity Shader 入门精要》配套：水面、雾效、边缘检测等 |
| 根目录 | 1 | SurfaceShader.shader：Surface Shader 示例 |
| **合计** | **130** | |

## 分类简介

### Animation — 着色器动画
基于深度图的 2D 角色动画、顶点动画（鱼游动、蝴蝶扇翅）、Q 弹果冻形变等。

### Base — 基础着色器
深度纹理渲染，是许多高级效果（阴影、雾效、后处理）的基础。

### Cubemap — 立方体贴图
使用 Cubemap 实现环境反射和折射效果，包含运行时渲染 Cubemap 的编辑器工具。

### Effect — 视觉特效
项目最大的分类，包含 2D/3D 描边、泛光、模糊、溶解、热浪、遮罩、沙化、科幻特效（全息屏幕、扫描线、线框）、卡通水面、水面模拟、放大镜等 48 个 Shader。

### GeometryShader — 几何着色器
几何着色器基础示例（锥体、线段、点、凸起）和草地渲染（结合曲面细分和风扰动）。

### GpuInstance — GPU 实例化
使用 `MaterialPropertyBlock` 和 `UNITY_INSTANCING_BUFFER` 实现 GPU 实例化，减少 Draw Call。

### Lighting — 光照模型
逐顶点/逐像素漫反射、半兰伯特光照、Phong/Blinn-Phong 高光模型。

### Math — 数学工具
Perlin 噪声纹理生成器（C# 脚本实现，非 Shader 文件）。

### PBR — 物理渲染
功能完备的手写 PBR（AlfxPBR）、Unity Standard Shader、基于教程的 PBR 系列着色器。

### PostProcessing — 后处理
Bloom、高斯模糊、边缘检测、运动模糊、亮度/饱和度/对比度调整，以及来自 PPSSPP 的后处理着色器集合。

### ScreenSpace — 屏幕空间
屏幕空间反射（SSR），使用 GrabPass 和射线步进实现。

### Shadow — 阴影
基础 ShadowMap 渲染、带 Bias 和 PCF 软阴影的改进版本。

### Skybox — 天空盒
来自外部资源的 darkskies 天空盒着色器（Quake3 格式，非 Unity 原生 Shader）。

### UI — UI 着色器
UI 毛玻璃模糊效果，支持 Stencil 遮罩和 Alpha 裁剪。

### Unity_Shaders_Book — 配套着色器
《Unity Shader 入门精要》第 11/13/15 章的配套 Shader：水面扭曲、基于深度纹理的雾效/运动模糊/边缘检测、噪声雾效。

## 技术栈

- **Unity 版本：** 2018.4.36f1
- **渲染管线：** Built-in Render Pipeline（内置管线）
- **着色器语言：** CG/HLSL（`CGPROGRAM`/`ENDCG`）
- **Shader Model：** 大部分要求 SM 3.0，几何着色器和曲面细分类要求 SM 4.0/4.6
- **平台要求：** Windows/Mac，需支持对应 Shader Model 的 GPU

## 使用方法

1. **克隆项目：**
   ```bash
   git clone https://github.com/wangshucheng/UnityShaderComplete.git
   ```

2. **用 Unity 打开：** 使用 Unity 2018.4.36f1（或兼容版本）打开项目。

3. **浏览着色器：** 在 Project 窗口中导航到 `Assets/` 下各分类目录，每个分类都有 `README.md` 说明文档。

4. **应用到材质：** 在材质球 Inspector 中选择对应的 Shader 路径（如 `MyShader/Effect/Dissolved`）。

5. **运行示例场景：** 部分子目录包含示例场景（.unity），可直接运行查看效果。

## 已完成的兼容性修复

详见 [COMPATIBILITY_FIXES.md](./COMPATIBILITY_FIXES.md)。

主要修复内容：
- `mul(UNITY_MATRIX_MVP, *)` → `UnityObjectToClipPos(*)`（矩阵变换 API 更新）
- `unity_ObjectToWorld` / `unity_WorldToObject` 变量名更新
- 移除已废弃的 `BindChannels` 指令
- `#pragma target` 声明统一添加
- `UnityGC.cginc` 引用修正

## 参考资源

- [ShaderLib — llapuras](https://github.com/llapuras/ShaderLib) — 基础 shader 效果收藏
- [Awesome Unity Open Source](https://github.com/baba-s/awesome-unity-open-source-on-github) — Unity 开源项目汇总
- [X-PostProcessing-Library — 浅墨](https://github.com/QianMo/X-PostProcessing-Library) — 高品质后处理库
- [HoloShield — AdultLink](https://github.com/AdultLink/HoloShield) — 科幻风格 Shader
- [Unity Shader 入门精要 — 冯乐乐](https://github.com/candycat1992/Unity_Shaders_Book) — 配套着色器源码

