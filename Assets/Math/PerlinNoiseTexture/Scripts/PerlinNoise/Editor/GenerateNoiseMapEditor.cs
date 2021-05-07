using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;

[CustomEditor(typeof(GenerateNoiseMap))]
public class GenerateNoiseMapEditor :Editor
{
    private readonly string mNoiseTexName = "PerlinNoiseTex";
    private GenerateNoiseMap mGenerateNoiseMap;

    void OnEnable()
    {
        mGenerateNoiseMap = target as GenerateNoiseMap;
    }

    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        if (GUILayout.Button("Generate Noise Map"))
        {
            mGenerateNoiseMap.CreateCubeMap();
        }
        if (GUILayout.Button("Clear Noise Map"))
        {
            mGenerateNoiseMap.ClearCubeMap();
        }
        GUILayout.Space(50);

        if (GUILayout.Button("Create Noise Tex"))
        {
            Texture2D noiseTexture = mGenerateNoiseMap.GetNoiseTexture();
            if (null != noiseTexture)
            {
                File.WriteAllBytes(System.Environment.CurrentDirectory + "\\Assets\\" + mNoiseTexName + ".png", noiseTexture.EncodeToPNG());
                EditorUtility.DisplayDialog("成功", "噪声图\"" + mNoiseTexName + "\"" + "已在Assets目录下生成！", "确定", "取消");
                AssetDatabase.Refresh();
            }
        }


    }
}
