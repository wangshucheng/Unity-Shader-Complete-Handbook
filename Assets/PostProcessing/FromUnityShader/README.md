# PostProcessing / FromUnityShader

外部合并到 PostProcessing 分类的后处理着色器资源，涵盖抗锯齿、景深、HDR/Bloom、扭曲、复古 CRT、降噪等效果。

## 来源说明

主要来自 `shader_for_unity-master` 项目（作者 Lin Dong）和 PPSSPP 模拟器后处理着色器移植。

## Shader 清单

### Anti-Aliasing — 抗锯齿

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `shader_for_unity-master/Anti-Aliasing/SSAA/SSAA 1-2-3-4.shader` | `Custom/SSAA1` | 超采样抗锯齿（SSAA） | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |

### Post processing — 后处理集合

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `shader_for_unity-master/Post processing/Computerfault/ComputerFault.shader` | `Custom/ComputerFault` | 电脑故障效果（扫描线 + 噪声） | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Post processing/Depth Of Field/DOF add noise/DOF_add_noise.shader` | `Custom/DOF_A_N` | 景深 + 噪声扰动 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Post processing/Depth Of Field/DOF_post_process.shader` | `Custom/DOF_P_P` | 景深后处理 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Post processing/Distortion/Barrel/Barrel.shader` | `Custom/Barrel` | 桶形畸变 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Post processing/Distortion/fisheye/fasheye.shader` | `Custom/fasheye` | 鱼眼畸变 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Post processing/HDR&Bloom/HDRGlow.shader` | `Custom/HDRGlow` | HDR 泛光 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Post processing/Real-Time Denoising in games/Conventional geometry-aware filtering.shader` | `Custom/Conventional geometry-aware filtering` | 几何感知降噪 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/Real-Time Denoising in games/Specular Lobe-Aware Filtering and Upsampling.shader` | `Custom/Specular Lobe-Aware Filtering and Upsampling` | 高光滤波降噪 | ✅ 已修复：无已知问题 |

### 来自 PPSSPP 模拟器的后处理着色器（移植到 Unity）

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/FXAA.shader` | `Custom/FXAA` | 快速近似抗锯齿 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/Retroc_CRT.shader` | `Custom/Retroc_CRT` | 复古 CRT 显示器效果 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/aacolor.shader` | `Custom/aacolor` | 抗锯齿颜色校正 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/bloom.shader` | `Custom/bloom` | 泛光（PPSSPP 移植） | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/cartoon.shader` | `Custom/cartoon` | 卡通化后处理 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/grayscale.shader` | `Custom/grayscale` | 灰度化 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/inversecolors.shader` | `Custom/inversecolors` | 反色 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/natural.shader` | `Custom/natural` | 自然色彩增强 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/scanlines.shader` | `Custom/scanlines` | 扫描线效果 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/sharpen.shader` | `Custom/sharpen` | 锐化 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/upscale_spline36.shader` | `Custom/upscale_spline36` | Spline36 放大插值 | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/Post processing/shaders from ppsspp used in Unity3d/vignette.shader` | `Custom/vignette` | 暗角效果 | ✅ 已修复：无已知问题 |

## 修复状态总结

| 修复类型 | 影响 Shader 数 | 说明 |
|----------|---------------|------|
| `mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` | 7 | Unity 5.6+ 矩阵变换 API 更新 |
| `.meta.meta` 重复文件清理 | 全部 | 清理 Unity 旧版生成的冗余 meta 文件 |

## 兼容性说明

- 后处理 Shader 需要配合 C# 脚本使用 `Graphics.Blit()` 渲染到 RenderTexture
- PPSSPP 移植的 Shader 文件名带空格，Unity 中路径需用引号包裹
- CRT、扫描线等复古效果适合做复古风格游戏
- 景深效果（`DOF_*`）需要深度纹理支持
