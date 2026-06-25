[toc]

# UnityShaderComplete
Unity Shader 完全手册

## Algorithm 算法
## Animation 动画

- DepthMapKitty 仿猫和老鼠片头3D狮子
- FishNButterfly 顶点动画，游动的鱼和扇动的蝴蝶
- Qspring Q弹果冻效果

## Base 基础

- DepthTexture 深度图

## CommandBuffer 命令缓冲

## ComputeShader 计算着色器

## Cubemap 立方体贴图
- Reflection 反射
- Refraction 折射
- RenderCubemap 渲染Cubemap来做反射和折射

## Effect 特效
- 2D_Outline
- 2D_Shadow
- 3D_Outline
- Bloom
- Blur 模糊
- Dissolve 消融
- Dissolve2 溶解
- DoubleTex 点光源，合适3D解密
- HeatWave 热浪
- Mask 遮罩，合适2D解密
- Sand 沙化，效果一般
- Sci-fi 科幻
- Water 卡通水体
- WaterSurfaceSimulation 水面模拟
- Zoom 放大镜

## GeometryShader
- [几何着色器]: .\Assets\GeometryShader\README.md

## GpuInstance
- [GPU-Instance]: .\Assets\GpuInstance\README.md

## Lighting 光照
- Diffuse 漫反射
- Specular 高光

## Math 数学
- PerlinNoiseTexture Perlin噪声纹理

## PBR 物理渲染
- [基于物理渲染Physics-based rendering]: .\Assets\PBR\README.md

## Pipeline 管线
## PostProcessing 后处理
## ScreenSpace 屏幕空间

- ScreenSpaceReflection 屏幕空间反射

## Shadow 阴影


# 引用

- [ShaderLib/BlurEffect at master · llapuras/ShaderLib (github.com)](https://github.com/llapuras/ShaderLib)
- [Awesome Unity Open Source on GitHub (800+)](https://github.com/baba-s/awesome-unity-open-source-on-github)·基础shader效果比较齐全的收藏repo，感谢整理！
- [XPL: Unity引擎的高品质后处理库](https://github.com/QianMo/X-PostProcessing-Library)·浅墨大佬的后处理库
- [HoloShield](https://github.com/AdultLink/HoloShield)·科幻风格shader(这大哥的几个repo都是挺科幻风的unity特效repo


## 合并记录（FromUnityShader）

本次将外部 UnityShader 资源合并到 `Assets/{Category}/FromUnityShader/` 分类目录下，并按功能分类整理。

| 分类 | 文件数量 | 说明 |
|------|----------|------|
| Effect | 97 | 视觉特效：流体、水波、老电影、死亡、浮雕、描边、精灵动画、GodRay 等 |
| PostProcessing | 85 | 后处理：抗锯齿、景深、HDR/Bloom、扭曲、复古 CRT、降噪等 |
| PBR | 20 | 物理材质示例与演示模型 |
| Lighting | 9 | 光照示例：顶点/像素漫反射 |
| Cubemap | 5 | 立方体贴图反射 |
| Animation | 1 | 着色器动画效果 |
| Skybox | 10 | 天空盒/环境着色器 |
| GeometryShader | 1 | 几何着色器示例 |
| Other | 1 | 杂项资源与共享模型 |

> 仅统计非 `.meta` 文件。Shader 数量请参见各分类下的 `README.md`。
