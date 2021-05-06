using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class GenerateNoiseMap : MonoBehaviour
{
    public DrawNoiseModel currDrawModel = DrawNoiseModel.HeightNoiseMap;
    public int mMapWidth = 50;
    public int mMapHeight = 50;
    [Range(0,100)]
    public float mNoiseScale = 0.5f;
    public int mOctaves = 4;
    [Range(0,1)]
    public float mPersistance = 0.5f;
    public float mLacunarity = 2;
    [Range(-100000,100000)]
    public int seed = 0;
    public Vector2 offset;
    public MapEditorData[] mapEditorData;
    public int cubeMaxHeight;

    void Start()
    {
        
    }

    void Update()
    {
        GenerateNoiseTex();
    }

    private void OnValidate()
    {
        if (mMapWidth < 1)
            mMapWidth = 1;

        if (mMapHeight < 1)
            mMapHeight = 1;

        if (mLacunarity < 1)
            mLacunarity = 1;

        if (mOctaves < 0)
        {
            mOctaves = 0;
        }

    }

    /// <summary>
    /// 生成噪声图
    /// </summary>
    private void GenerateNoiseTex()
    {
        float[,] noiseData = PerlinNoise.GereratePerlinNoise(mMapWidth, mMapHeight,mNoiseScale, mOctaves, mPersistance, mLacunarity, seed, offset);

        NoiseMapDisplay mapDisplay = FindObjectOfType<NoiseMapDisplay>();
        if (null == mapDisplay)
        {
            Debug.LogError("请确保NoiseMapDisplay脚本在运作，并设定好了相应的环境！");
            return;
        }

        if (DrawNoiseModel.HeightNoiseMap == currDrawModel)
        {
            mapDisplay.DrawNoiseHeightMap(noiseData);
        }
        else if (DrawNoiseModel.ColorNoiseMap == currDrawModel)
        {
            CreateColorNoiseMap(mapDisplay);
        }
        
    }

    /// <summary>
    /// 创建柏林噪声地图
    /// </summary>
    public void CreateColorNoiseMap(NoiseMapDisplay mapDisplay)
    {
        float[,] noiseData = PerlinNoise.GereratePerlinNoise(mMapWidth, mMapHeight, mNoiseScale, mOctaves, mPersistance, mLacunarity, seed, offset);

        Color[] colorMap = new Color[mMapWidth * mMapHeight];
        for (int y = 0; y < mMapHeight; y++)
        {
            for (int x = 0; x < mMapWidth; x++)
            {
                float currNoiseHeight = noiseData[x, y];
                for (int i = 0,len = mapEditorData.Length; i < len; i++)
                {
                    if (currNoiseHeight <= mapEditorData[i].nHeight)
                    {
                        colorMap[y * mMapWidth + x] = mapEditorData[i].color;
                        break;
                    }
                }
            }
        }

        mapDisplay.DrawNoiseColorMap(colorMap, mMapWidth, mMapHeight);
    }

    /// <summary>
    /// 获取编辑器下预览的噪声图
    /// </summary>
    public Texture2D GetNoiseTexture()
    {
        NoiseMapDisplay mapDisplay = FindObjectOfType<NoiseMapDisplay>();
        if (null == mapDisplay || null == mapDisplay.mRendererTexture)
        {
            Debug.LogError("请确保NoiseMapDisplay脚本在运作，并设定好了相应的环境！");
            return null;
        }

        return mapDisplay.mRendererTexture.sharedMaterial.mainTexture as Texture2D;
    }


    /// <summary>
    /// 清理Cube创建的地图
    /// </summary>
    public void ClearCubeMap()
    {
        if (this.transform.childCount > 0)
        {
            for (int i = this.transform.childCount - 1; i >= 0; i--)
            {

#if UNITY_EDITOR
                DestroyImmediate(this.transform.GetChild(i).gameObject);
#else
                Destroy(this.transform.GetChild(i).gameObject);
#endif
            }
        }
    }


    /// <summary>
    /// 创建cube地图
    /// </summary>
    public void CreateCubeMap()
    {
        ClearCubeMap();

        float[,] noiseData = PerlinNoise.GereratePerlinNoise(mMapWidth, mMapHeight, mNoiseScale, mOctaves, mPersistance, mLacunarity, seed, offset);

        Color[] colorMap = new Color[mMapWidth * mMapHeight];
        for (int y = 0; y < mMapHeight; y++)
        {
            for (int x = 0; x < mMapWidth; x++)
            {
                float currNoiseHeight = noiseData[x, y];
                for (int i = 0, len = mapEditorData.Length; i < len; i++)
                {
                    if (currNoiseHeight <= mapEditorData[i].nHeight)
                    {
                        colorMap[y * mMapWidth + x] = mapEditorData[i].color;
                        break;
                    }
                }
            }
        }

        for (int y = 0; y < mMapHeight; y++)
        {
            for (int x = 0; x < mMapWidth; x++)
            {
                float halfWidth = mMapWidth / 2;
                float halfHeight = mMapHeight / 2;

                Vector3 vec3 = new Vector3(x - halfWidth, noiseData[x,y] * cubeMaxHeight, y - halfHeight);
                GameObject cubeObj = GameObject.CreatePrimitive(PrimitiveType.Cube);
                cubeObj.transform.SetParent(this.transform);
                cubeObj.transform.position = vec3;
                cubeObj.GetComponent<Renderer>().material = new Material(Shader.Find("Standard"));
                cubeObj.GetComponent<Renderer>().material.color = colorMap[y * mMapWidth + x];
            }
        }
    }
}

[System.Serializable]
public struct MapEditorData
{
    public string strTypeName;
    public float nHeight;
    public Color color;
}

public enum DrawNoiseModel
{
    None,
    HeightNoiseMap,
    ColorNoiseMap
}
