# GeometryShader — 几何着色器

几何着色器示例和草地渲染系统。几何着色器可以在 GPU 管线中增删改图元，实现程序化几何体生成。

## Shader 清单

### Example — 基础示例

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Example/Res/Shader/jianciShader.shader` | `MyShader/jianciShader` | 锥体生成，根据三角面法线生成锥体 | Vert/Frag/Geometry, SM 4.0, TriangleStream |
| `Example/Res/Shader/lineShader.shader` | `MyShader/lineShader` | 线段生成，将三角面转为线框 | Vert/Frag/Geometry, SM 4.0 |
| `Example/Res/Shader/otherShader.shader` | `MyShader/otherShader` | 毛发效果，几何着色器生成毛发层 | Vert/Frag/Geometry, SM 4.0 |
| `Example/Res/Shader/pointShader.shader` | `MyShader/pointShader` | 点生成，将顶点转为点云 | Vert/Frag/Geometry, SM 4.0 |
| `Example/Res/Shader/testShader.shader` | `MyShader/GSTest` | 几何着色器测试，法线方向锥体 | Vert/Frag/Geometry, SM 4.0 |
| `Example/Res/Shader/tuqiShader.shader` | `MyShader/tuqiShader` | 凸起效果，三角面沿法线凸出 | Vert/Frag/Geometry, SM 4.0 |

### Grass — 草地渲染

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Grass/Shaders/Grass.shader` | `Roystan/Grass` | 草地渲染，几何着色器生成草叶 + 风扰动 | Vert/Frag/Geometry, Tessellation, SM 5.0, Wind Map |
| `Grass/Shaders/TessellationExample.shader` | `Roystan/Tessellation Example` | 曲面细分示例 | Vert/Frag/Hull/Domain, SM 4.6, CustomTessellation.cginc |

## 子目录

| 子目录 | 说明 |
|--------|------|
| `Example/` | 几何着色器基础示例（6 个 Shader） |
| `Grass/` | 草地渲染系统（2 个 Shader + 1 个 cginc） |
| `FromUnityShader/` | 外部合并的几何着色器资源（详见子目录 README） |

## 技术说明

几何着色器核心模式：
```
[maxvertexcount(N)]
void geom(triangle v2g IN[3], inout TriangleStream<g2f> tristream) {
    // 生成新顶点并追加到流
    tristream.Append(o);
    tristream.RestartStrip();
}
```

## 兼容性说明

- 几何着色器需要 SM 4.0+，曲面细分需要 SM 4.6+
- `Grass.shader` 同时使用几何着色器和曲面细分，需要 SM 5.0
- 几何着色器并行度低，性能不如顶点/片段着色器，不适合移动端
- `CustomTessellation.cginc` 为草地着色器提供曲面细分辅助函数
