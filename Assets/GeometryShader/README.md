[toc]

# GeometryShader
几何着色器

## 特点
- 增删改模型顶点和三角面
- 并行调用硬件困难，并行程度低，效率和顶点着色器有很大的差距

## 代码

```Shaderlab
Pass
{
	#pragma target 4.0
    ...
    #pragma geometry geom
    ...

    void ADD_VERT(float3 v,g2f o,inout TriangleStream<g2f> tristream)
    {
       o.vertex = UnityObjectToClipPos(v); 
       // 添加点
       tristream.Append(o);
    }

    void  ADD_TRI(float3 p0,float3 p1,float3 p2,g2f o,inout TriangleStream<g2f> tristream)
    {
        ADD_VERT(p0,o,tristream);
        ADD_VERT(p1,o,tristream);
        ADD_VERT(p2,o,tristream);
        // 每当构建一个三角形都需要调用一次tristream.RestartStrip();
        tristream.RestartStrip();
    }

    // 几何着色器为单个调用输出的顶点的最大数量。对于我的理解就是你要单次执行最终输出结果的总的顶点数量。官方指出出于性能考虑，最大顶点数应尽可能小。
    [maxvertexcount(9)]
    // 输入 point line triangle lineadj triangleadj
    // 输出: PointStream只显示点，LineStream只显示线，TriangleStream全显
    void geom(triangle v2g IN[3], inout TriangleStream<g2f> tristream)
    {
        g2f o; 
        //--------计算原模型三角面的法线
        float3 edgeA = IN[1].vertex - IN[0].vertex;
        float3 edgeB = IN[2].vertex - IN[0].vertex;
        float3 normalFace = normalize(cross(edgeA, edgeB));
        //-------
        o.norg=-normalFace;
        //根据模型三角面信息额外生成一个向外突出的锥体
        float3 v0 = IN[0].vertex;
        float3 v1 = IN[1].vertex;
        float3 v2 = IN[2].vertex;
        float3 v3 = (IN[0].vertex+IN[1].vertex+IN[2].vertex)/3 + normalFace * _Length;				
        ADD_TRI(v0,v3,v2,o,tristream);
        ADD_TRI(v0,v1,v3,o,tristream);
        ADD_TRI(v2,v3,v1,o,tristream);
    }
}
```

