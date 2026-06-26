# PostProcessing — 后处理

屏幕空间后处理效果集合，包括 Bloom、高斯模糊、边缘检测、运动模糊、亮度/饱和度/对比度调整，以及来自 PPSSPP 的后处理着色器集合。

## Shader 清单

### Shaders — 《Unity Shader 入门精要》第 12 章

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Shaders/Chapter12-Bloom.shader` | `Unity Shaders Book/Chapter 12/Bloom` | 泛光效果（阈值提取 + 高斯模糊 + 叠加） | Vert/Frag, CGINCLUDE, 2 Pass |
| `Shaders/Chapter12-GaussianBlur.shader` | `Unity Shaders Book/Chapter 12/Gaussian Blur` | 高斯模糊（双 Pass 分离卷积） | Vert/Frag, CGINCLUDE, 2 Pass |
| `Shaders/Chapter12-EdgeDetection.shader` | `Unity Shaders Book/Chapter 12/Edge Detection` | Sobel 边缘检测 | Vert/Frag, ZTest Always, Sobel 算子 |
| `Shaders/Chapter12-MotionBlur.shader` | `Unity Shaders Book/Chapter 12/Motion Blur` | 运动模糊（帧累积混合） | Vert/Frag, Blend, 2 Pass |
| `Shaders/Chapter12-BrightnessSaturationAndContrast.shader` | `Unity Shaders Book/Chapter 12/Brightness Saturation And Contrast` | 亮度/饱和度/对比度调整 | Vert/Frag, 单 Pass |
| `Shaders/Common/BumpedDiffuse.shader` | `Unity Shaders Book/Common/Bumped Diffuse` | 带法线贴图的漫反射（通用着色器） | Vert/Frag, 2 Pass, Blend, multi_compile_fwdbase |

### FromUnityShader — 外部合并的后处理

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `FromUnityShader/shader_for_unity-master/Anti-Aliasing/SSAA/SSAA 1-2-3-4.shader` | `Custom/SSAA1` | 超采样抗锯齿（SSAA） | Vert/Frag, 多分辨率采样 |
| `FromUnityShader/shader_for_unity-master/Post processing/Computerfault/ComputerFault.shader` | `Custom/ComputerFault` | 电脑故障效果 | Vert/Frag, 扫描线 + 噪声 |
| `FromUnityShader/shader_for_unity-master/Post processing/Depth Of Field/DOF_add_noise.shader` | `Custom/DOF_A_N` | 景深 + 噪声 | Vert/Frag, 深度采样, 模糊 |
| `FromUnityShader/shader_for_unity-master/Post processing/Depth Of Field/DOF_post_process.shader` | `Custom/DOF_P_P` | 景深后处理 | Vert/Frag, 深度采样 |
| `FromUnityShader/shader_for_unity-master/Post processing/Distortion/Barrel/Barrel.shader` | `Custom/Barrel` | 桶形畸变 | Vert/Frag, UV 畸变 |
| `FromUnityShader/shader_for_unity-master/Post processing/Distortion/fisheye/fasheye.shader` | `Custom/fasheye` | 鱼眼畸变 | Vert/Frag, UV 畸变 |
| `FromUnityShader/shader_for_unity-master/Post processing/HDR&Bloom/HDRGlow.shader` | `Custom/HDRGlow` | HDR 泛光 | Vert/Frag, 曝光 + 高光提取 |
| `FromUnityShader/shader_for_unity-master/Post processing/Real-Time Denoising in games/Conventional geometry-aware filtering.shader` | `Custom/Conventional geometry-aware filtering` | 几何感知降噪 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/Real-Time Denoising in games/Specular Lobe-Aware Filtering and Upsampling.shader` | `Custom/Specular Lobe-Aware Filtering and Upsampling` | 高光滤波降噪 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/FXAA.shader` | `Custom/FXAA` | 快速近似抗锯齿（FXAA） | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/Retroc_CRT.shader` | `Custom/Retroc_CRT` | 复古 CRT 显示器效果 | Vert/Frag, 扫描线 |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/aacolor.shader` | `Custom/aacolor` | 抗锯齿颜色校正 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/bloom.shader` | `Custom/bloom` | 泛光（PPSSPP 移植） | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/cartoon.shader` | `Custom/cartoon` | 卡通化后处理 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/grayscale.shader` | `Custom/grayscale` | 灰度化 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/inversecolors.shader` | `Custom/inversecolors` | 反色 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/natural.shader` | `Custom/natural` | 自然色彩增强 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/scanlines.shader` | `Custom/scanlines` | 扫描线效果 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/sharpen.shader` | `Custom/sharpen` | 锐化 | Vert/Frag, 锐化卷积 |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/upscale_spline36.shader` | `Custom/upscale_spline36` | Spline36 放大插值 | Vert/Frag |
| `FromUnityShader/shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/vignette.shader` | `Custom/vignette` | 暗角效果 | Vert/Frag |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `Shaders/` | 《Unity Shader 入门精要》第 12 章后处理（6 个 Shader） |
| `FromUnityShader/` | 外部合并的后处理着色器（22 个 Shader，详见子目录 README） |

## 兼容性说明

- 后处理 Shader 需要配合 C# 脚本使用 `Graphics.Blit()` 渲染到 RenderTexture
- `Chapter12-Bloom` 和 `Chapter12-GaussianBlur` 使用 CGINCLUDE 共享代码
- PPSSPP 移植的 Shader 文件名带空格，路径需用引号包裹
