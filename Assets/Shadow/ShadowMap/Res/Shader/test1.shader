Shader "test1"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;

            struct v2f {
                float4 pos:SV_POSITION;
                float4 worldPos : TEXCOORD0;
            };


            float4x4 _LightProjection;
            sampler2D _LightDepthTex;

            v2f vert(appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld,v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //换到裁切坐标
                fixed4 ndcpos = mul(_LightProjection , i.worldPos);
                ndcpos.xyz = ndcpos.xyz / ndcpos.w ;
                //从[-1,1]转换到[0,1]
                float3 uvpos = ndcpos * 0.5 + 0.5 ;
                //采遮挡物的深度信息
                float depth = DecodeFloatRGBA(tex2D(_LightDepthTex, uvpos.xy));
                //挡住了就是黑色
                if(ndcpos.z < depth){return 1;}
                else{return 0;}
            }
            ENDCG
        }
    }
}
