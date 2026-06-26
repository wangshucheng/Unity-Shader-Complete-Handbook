# GpuInstance — GPU 实例化

使用 GPU 实例化技术批量渲染相同网格的多个副本，大幅减少 Draw Call。

## Shader 清单

| 文件路径 | Shader 名称 | 功能描述 | 技术要点 |
|----------|-------------|----------|----------|
| `Resources/Shader/PropertyBlock.shader` | `MyShader/GpuInstance/PropertyBlock` | GPU 实例化 + MaterialPropertyBlock 每实例颜色 | Vert/Frag, multi_compile_instancing, UNITY_INSTANCING_BUFFER |

## 技术要点

- **`#pragma multi_compile_instancing`**：启用 GPU 实例化变体
- **`UNITY_VERTEX_INPUT_INSTANCE_ID`**：在顶点输入/输出结构体中添加实例 ID
- **`UNITY_SETUP_INSTANCE_ID`**：在着色器函数中设置实例 ID
- **`UNITY_INSTANCING_BUFFER` / `UNITY_DEFINE_INSTANCED_PROP`**：定义每实例属性
- **`UNITY_ACCESS_INSTANCED_PROP`**：访问每实例属性

## 使用方法

1. 在 C# 脚本中使用 `MaterialPropertyBlock` 设置每个实例的属性：
   ```csharp
   MaterialPropertyBlock mpb = new MaterialPropertyBlock();
   mpb.SetColor("_Color", color);
   renderer.SetPropertyBlock(mpb);
   ```

2. 通过 `SystemInfo.supportsInstancing` 判断硬件是否支持 GPU 实例化

## 兼容性说明

- 需要 SM 3.0+ 和 OpenGL ES 3.0+ 支持
- 实例属性通过 `UNITY_INSTANCING_BUFFER` 定义，不兼容 SRP Batcher
