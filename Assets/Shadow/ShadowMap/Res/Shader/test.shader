Shader "test"
{
    SubShader
    {
        //表示非透明，在这里没啥用
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 depth: TEXCOORD0;
            };

            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.depth = o.vertex.zw ;
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                float depth = i.depth.x/i.depth.y ;
                //这个接口可以用color存储一个float
                return EncodeFloatRGBA(depth) ;
            }
            ENDCG
        }
    }
}