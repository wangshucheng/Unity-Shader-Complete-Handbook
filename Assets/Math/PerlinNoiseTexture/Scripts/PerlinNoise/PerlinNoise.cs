using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PerlinNoise
{
    /// <summary> 噪音数据 </summary>
    //private static float[,] mNoiseData;


    private PerlinNoise() { }


    /// <summary>
    /// 生成柏林噪音数据
    /// </summary>
    /// <param name="width">宽度</param>
    /// <param name="hight">高度</param>
    /// <param name="seed">随机数种子</param>
    /// <param name="scale">缩放</param>
    /// <param name="octaves">倍频</param>
    /// <param name="persistance">通过[倍频]作用影响[频率]的系数</param>
    /// <param name="lacunarity">通过[倍频]作用影响[频率]的系数</param>
    /// <returns></returns>
    public static float[,] GereratePerlinNoise(int width,int height,float scale,int octaves,float persistance,float lacunarity, int seed,Vector2 offset)
    {
        float[,] mNoiseData = new float[width, height];

        if (scale < 0.0001f)
        {
            scale = 0.0001f;
        }

        System.Random prng = new System.Random(seed);
        Vector2[] octaveOffsets = new Vector2[octaves];

        for (int i = 0; i < octaves; i++)
        {
            float offsetX = prng.Next(-100000,100000) + offset.x;
            float offsetY = prng.Next(-100000, 100000) + offset.y ;
            octaveOffsets[i] = new Vector2(offsetX, offsetY);
        }

        float minNoiseHeight = float.MaxValue;
        float maxNoiseHeight = float.MinValue;
        float halfWidth = width / 2;
        float halfHeight = height / 2;
        
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                float amplitude = 1;                    //振幅
                float frequency = 1;                    //频率
                float noiseHeight = 0;
                for (int i = 0; i < octaves; i++)
                {
                    float sampleX = (x - halfWidth) / scale * frequency + octaveOffsets[i].x;
                    float sampleY = (y - halfHeight) / scale * frequency + octaveOffsets[i].y;

                    float perlinValue = Mathf.PerlinNoise(sampleX, sampleY) * 2 - 1;
                    noiseHeight = perlinValue * amplitude;

                    amplitude *= persistance;
                    frequency *= lacunarity;

                    if (noiseHeight > maxNoiseHeight)
                    {
                        maxNoiseHeight = noiseHeight;
                    }
                    else if (noiseHeight < minNoiseHeight)
                    {
                        minNoiseHeight = noiseHeight;
                    }
                }
                mNoiseData[x, y] = noiseHeight;
            }
        }

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                //变换[0,1]范围
                mNoiseData[x, y] = Mathf.InverseLerp(minNoiseHeight,maxNoiseHeight, mNoiseData[x,y]);  
            }
        }

        return mNoiseData;
    }

}
