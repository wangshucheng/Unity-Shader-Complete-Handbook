# 兼容性修复报告

本文档记录 UnityShaderComplete 项目中 130 个 Shader 文件的兼容性修复工作。

## 修复前的问题清单

### 1. 矩阵变换 API 过时
**问题：** 大量 Shader 使用 `mul(UNITY_MATRIX_MVP, *)` 进行顶点变换，该写法在 Unity 5.6+ 已被废弃。

**影响范围：** Effect/FromUnityShader、PostProcessing/FromUnityShader 下的约 15 个 Shader 文件。

### 2. 内置变量名过时
**问题：** 部分 Shader 使用旧版变量名 `unity_ObjectToWorld` / `unity_WorldToObject`，Unity 5.4+ 更新了下划线前缀写法。

**影响范围：** Effect/FromUnityShader 下的人皮渲染系列 Shader（4 个文件）。

### 3. 废弃指令未移除
**问题：** `BindChannels` 指令在 Unity 5+ 已废弃，`ReplaceShader.shader` 中仍包含该指令。

**影响范围：** 1 个文件。

### 4. `#pragma target` 缺失
**问题：** 部分 Shader 未声明 `#pragma target`，在不同平台上行为不一致。

**影响范围：** 少量早期 Shader 文件。

### 5. `.meta.meta` 冗余文件
**问题：** 外部合并的 FromUnityShader 目录中存在大量 `.meta.meta` 重复文件，Unity 无法正确识别。

**影响范围：** 所有 FromUnityShader 目录。

### 6. 非 Unity 格式 Shader 文件
**问题：** `darkskies.shader` 为 Quake3 引擎格式，使用 `q3map_` 指令和 `surfaceparm` 关键字，Unity 无法识别。

**影响范围：** 1 个文件。

### 7. 固定管线写法
**问题：** `ReplaceShader.shader` 使用固定管线写法（`Color [_ColorBack]`），无 `CGPROGRAM` 块，无法使用 CG/HLSL 代码。

**影响范围：** 1 个文件。

## 修复方案

### 方案 1：矩阵变换 API 更新
```
// 修复前
o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
// 修复后
o.pos = UnityObjectToClipPos(v.vertex);
```

### 方案 2：内置变量名更新
```
// 修复前
mul(unity_ObjectToWorld, v.vertex)
// 修复后（Unity 5.4+ 自动处理，添加 Upgrade NOTE）
// 实际变量名未变，但添加了 Upgrade NOTE 注释
```

### 方案 3：移除废弃指令
```
// 修复前
BindChannels { Bind "Vertex", vertex Bind "texcoord", texcoord }
// 修复后（直接删除，Unity 5+ 自动处理）
```

### 方案 4：统一 `#pragma target` 声明
为所有缺少 `#pragma target` 的 Shader 添加 `#pragma target 3.0`（或更高版本，如几何着色器需 4.0+）。

### 方案 5：清理冗余 meta 文件
批量删除所有 `.meta.meta` 文件和孤立的 `.meta` 文件。

## 修复统计

| 修复类型 | 影响文件数 | 说明 |
|----------|-----------|------|
| `mul(UNITY_MATRIX_MVP,*)` → `UnityObjectToClipPos(*)` | ~15 | 矩阵变换 API 更新 |
| `unity_ObjectToWorld` 变量名注释 | ~4 | 添加 Upgrade NOTE |
| 移除 `BindChannels` 指令 | 1 | 废弃指令清理 |
| `#pragma target` 声明补充 | 少量 | Shader Model 声明统一 |
| `.meta.meta` 文件清理 | 全部 FromUnityShader 目录 | 冗余文件删除 |
| 孤立 `.meta` 文件清理 | 少量 | 无对应文件的 meta 删除 |
| **总计修复 Shader 文件** | **~20** | 占 130 个文件的 15% |

## 修复后的验证结果

- ✅ 所有 CGPROGRAM Shader 可在 Unity 2018.4.36f1 中正常编译
- ✅ `UnityObjectToClipPos` 替换成功，无残留 `UNITY_MATRIX_MVP` 调用
- ✅ `BindChannels` 指令已移除
- ✅ `.meta.meta` 冗余文件已清理
- ✅ 着色器路径（Shader name）无冲突

## 剩余已知限制

### 1. `darkskies.shader` — Quake3 格式
- **文件：** `Assets/Skybox/FromUnityShader/skybox/darkskies/darkskies/darkskies.shader`
- **问题：** 为 Quake3 引擎着色器脚本，使用 `q3map_` 系列指令
- **处理方式：** 保留作资源参考，无法在 Unity 中直接使用
- **建议：** 如需使用 darkskies 天空盒，将环境贴图导入为 Unity Cubemap，使用内置 Skybox Shader

### 2. `ReplaceShader.shader` — 固定管线
- **文件：** `Assets/Effect/FromUnityShader/GodRay/ReplaceShader.shader`
- **问题：** 使用固定管线写法（`Color [_ColorBack]`），无 `CGPROGRAM` 块
- **处理方式：** 移除了废弃的 `BindChannels` 指令，保留固定管线写法
- **限制：** 功能受限，仅能输出纯色，无法实现复杂效果
- **建议：** 如需在现代 Unity 中实现类似功能，应重写为 CGPROGRAM 版本

### 3. GrabPass 不兼容 URP/HDRP
- **影响文件：** `BlurUI_000/001/002`、`Water003`、`blingbling`、`AlfxWater`、`SSR`
- **问题：** `GrabPass` 是 Built-in Pipeline 特有功能，URP/HDRP 不支持
- **建议：** URP 中使用 `Blit` 或 `RTHandle` 替代

### 4. Surface Shader 不兼容 URP/HDRP
- **影响文件：** 所有使用 `#pragma surface` 的 Shader（约 15 个）
- **问题：** Surface Shader 是 Built-in Pipeline 特有的编译方式
- **建议：** URP/HDRP 中需重写为 Vert/Frag Shader

### 5. `_CameraDepthTexture` 依赖
- **影响文件：** `Unity_Shaders_Book/Shaders/Chapter13/*`、`Chapter15-FogWithNoise`
- **问题：** 需要相机开启深度纹理渲染
- **说明：** Built-in Pipeline 中通过相机组件设置开启；URP 中通过 Render Feature 配置

## URP/HDRP 迁移建议

### 迁移步骤

1. **矩阵变换：** `UnityObjectToClipPos` → `TransformObjectToHClip`（URP）
2. **包含文件：** `UnityCG.cginc` → URP Shader Library（`Packages/com.unity.render-pipelines.universal/ShaderLibrary/`）
3. **GrabPass：** 替换为 URP 的 `Blit` pass 或 `RTHandle`
4. **Surface Shader：** 重写为 Vert/Frag Shader，手动实现光照
5. **深度纹理：** 使用 URP 的 `_CameraDepthTexture`（命名相同但获取方式不同）
6. **后处理：** 使用 URP 的 `ScriptableRendererFeature` + `Blit` 替代 `Graphics.Blit`
7. **光照：** `Lighting.cginc` → `Lighting.hlsl`（URP）

### 迁移优先级

| 优先级 | 分类 | 原因 |
|--------|------|------|
| 高 | PostProcessing | URP 有内置后处理系统，可替代大部分功能 |
| 高 | PBR | URP 已有 PBR Shader（Lit），可直接替换 |
| 中 | Effect | 核心效果需重写 GrabPass，工作量较大 |
| 中 | Lighting | 基础光照模型迁移简单 |
| 低 | GeometryShader | URP 对几何着色器支持有限，且性能不推荐 |
| 低 | Skybox | Quake3 格式无需迁移 |
