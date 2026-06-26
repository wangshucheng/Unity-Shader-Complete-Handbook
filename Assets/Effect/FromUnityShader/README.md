# Effect / FromUnityShader

外部合并到 Effect 分类的着色器资源，涵盖 GodRay、流体、老电影、描边、皮肤/眼睛/植物/毛发渲染等高级效果。

## 来源说明

主要来自 `shader_for_unity-master` 项目（作者 Lin Dong，博客 http://blog.csdn.net/wolf96）和其他外部资源。

## Shader 清单

### GodRay — 体积光

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `GodRay/GodRay.shader` | `ZHH/GodRay` | 体积光后处理（径向采样 + 衰减） | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `GodRay/GodRayOptimize.shader` | `ZHH/GodRayOptimize` | 体积光优化版 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `GodRay/Blend.shader` | `ZHH/Blend` | 体积光混合 Pass | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `GodRay/ReplaceShader.shader` | `ZHH/ReplaceShader` | 替换着色器（固定管线，无 CGPROGRAM） | ⚠️ 已修复：移除废弃的 `BindChannels` 指令。仍为固定管线写法，仅作功能参考 |

### 死亡效果

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `death/DeathEffect.shader` | `Custom/DeathEffect` | 死亡灰度化效果（亮度计算 + 灰度混合） | ✅ 已修复：无已知问题 |

### 浮雕效果

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `embossment/Embossment.shader` | `Custom/Embossment` | 浮雕效果（卷积采样 + Blend） | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |

### 流体效果

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `fluid/FluidEffect.shader` | `Custom/FluidEffect` | 流体纹理滚动（UV 滚动动画） | ✅ 已修复：无已知问题 |
| `fluid/FluidEffect1.shader` | `Custom/FluidEffect1` | 流体效果 PBR 版本 | ✅ 已修复：无已知问题 |

### 老电影效果

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `oldFilm/OldFilm.shader` | `Custom/OldFilm` | 老电影效果（暗角 + 划痕 + 灰尘 + 棕褐色调） | ✅ 已修复：无已知问题 |

### 卡通描边

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `outline/outline.shader` | `Custom/toon` | 卡通描边 + 色阶量化 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |

### 精灵动画

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `sprite/SpriteEffect.shader` | `Custom/SpriteEffect` | 精灵帧动画播放（UV 切片） | ✅ 已修复：无已知问题 |

### 水波纹

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `water/WaterRipple.shader` | `Custom/WaterRipple` | 水波纹效果（Surface Shader + Standard） | ✅ 已修复：无已知问题 |

### shader_for_unity-master — 高级渲染系列

| 文件名 | Shader 名称 | 功能 | 修复状态 |
|--------|-------------|------|----------|
| `shader_for_unity-master/Human skin realtime rendering/HumanSkin.shader` | `Custom/HumanSkin` | 人皮实时渲染 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)`，`unity_ObjectToWorld` 变量名更新 |
| `shader_for_unity-master/Human skin realtime rendering/plus effect/Blood Effect/HumanSkinWithBlood.shader` | `Custom/HumanSkinWithBlood` | 人皮 + 血液效果 | ✅ 已修复：同上 |
| `shader_for_unity-master/Human skin realtime rendering/plus effect/Water Drop Effect/HumanSkinWithWaterDrop.shader` | `Custom/blood` | 人皮 + 水滴效果 | ✅ 已修复：同上 |
| `shader_for_unity-master/Human skin realtime rendering/superaddition/HumanSkin_plus.shader` | `Custom/HumanSkin_plus` | 人皮增强版（Oren-Nayar + SSS） | ✅ 已修复：同上 |
| `shader_for_unity-master/Realistic eye shading/eye Shading.shader` | `Custom/eye Shading` | 写实眼睛渲染 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Realistic eye shading/eye no detial Spec Shading.shader` | `Custom/eye no detial Spec Shading` | 写实眼睛（无巩膜高光） | ✅ 已修复：同上 |
| `shader_for_unity-master/Realistic plant shading/plant1.shader` | `Custom/plant1` | 写实植物渲染 v1 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/Realistic plant shading/plant2.shader` | `Custom/plant2` | 写实植物渲染 v2 | ✅ 已修复：同上 |
| `shader_for_unity-master/fur/fur.shader` | `Custom/sufaceshaderYuan` | 毛发渲染（Surface Shader + 曲面细分） | ✅ 已修复：无已知问题 |
| `shader_for_unity-master/random generation terrain based on fractal noise/terrain.shader` | `Custom/terrain` | 分形噪声地形生成 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |
| `shader_for_unity-master/snow and sand/snow.shader` | `Custom/snow` | 雪地/沙地渲染 | ✅ 已修复：`mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` |

## 修复状态总结

| 修复类型 | 影响 Shader 数 | 说明 |
|----------|---------------|------|
| `mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` | 10 | Unity 5.6+ 矩阵变换 API 更新 |
| `unity_ObjectToWorld` / `unity_WorldToObject` 变量名 | 4 | Unity 5.4+ 内置变量名更新 |
| 移除废弃 `BindChannels` 指令 | 1 | Unity 5+ 已废弃 |
| `.meta.meta` 重复文件清理 | 全部 | 清理 Unity 旧版生成的冗余 meta 文件 |

## 兼容性说明

- `ReplaceShader.shader` 为固定管线写法（无 CGPROGRAM），仅保留作功能参考
- `fur.shader` 使用曲面细分，需要 SM 5.0+
- 皮肤渲染系列代码较复杂，包含 SSS、Oren-Nayar 等高级光照模型
