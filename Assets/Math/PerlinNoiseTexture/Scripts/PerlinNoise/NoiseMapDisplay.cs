using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NoiseMapDisplay : MonoBehaviour
{
    public Renderer mRendererTexture;

    /// <summary>
    /// 图形显示柏林噪声高度图
    /// </summary>
    /// <param name="noiseMap"></param>
    public void DrawNoiseHeightMap(float[,] noiseMap)
    {
        int width = noiseMap.GetLength(0);
        int height = noiseMap.GetLength(1);

        Texture2D newTexture = new Texture2D(width, height);
        Color[] noiseColor = new Color[width * height];

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                noiseColor[y * width + x] = Color.Lerp(Color.black, Color.white, noiseMap[x, y]);
            }
        }
        newTexture.filterMode = FilterMode.Point;
        newTexture.wrapMode = TextureWrapMode.Clamp;
        newTexture.SetPixels(noiseColor);
        newTexture.Apply();

        if (null != mRendererTexture)
        {
            mRendererTexture.sharedMaterial.mainTexture = newTexture;
        }
    }

    /// <summary>
    /// 图形显示柏林噪声颜色图
    /// </summary>
    /// <param name="noiseMap"></param>
    public void DrawNoiseColorMap(Color[] noiseColor,int width,int height)
    {
        Texture2D newTexture = new Texture2D(width, height);
        newTexture.filterMode = FilterMode.Point;
        newTexture.wrapMode = TextureWrapMode.Clamp;
        newTexture.SetPixels(noiseColor);
        newTexture.Apply();

        if (null != mRendererTexture)
        {
            mRendererTexture.sharedMaterial.mainTexture = newTexture;
        }
    }

}
