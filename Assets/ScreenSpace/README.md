# ScreenSpace — 屏幕空间效果

屏幕空间技术实现的渲染效果，目前包含屏幕空间反射（SSR）。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `ScreenSpaceReflection/Res/Shader/SSR.shader` | `MyShader/SSR` | 屏幕空间反射，通过 GrabPass 获取屏幕颜色，射线步进计算反射 | Vert/Frag, GrabPass, Ray Marching, 法线贴图, 噪声扰动 |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `ScreenSpaceReflection/` | 屏幕空间反射实现 |

## 技术说明

SSR 实现原理：
1. 使用 `GrabPass` 获取当前屏幕渲染结果
2. 对每个像素，根据法线和视线方向计算反射方向
3. 沿反射方向进行射线步进（Ray Marching）
4. 检测射线与深度缓冲的交点
5. 采样交点位置的屏幕颜色作为反射色

## 兼容性说明

- 使用 `GrabPass`，不兼容 URP/HDRP
- 需要 SM 3.0+，性能开销较大
- 对法线贴图和噪声纹理有依赖
