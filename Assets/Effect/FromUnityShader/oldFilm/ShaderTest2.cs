using UnityEngine;
using System.Collections;
[ExecuteInEditMode]
public class ShaderTest2 : MonoBehaviour
{
    #region Variables
    public Shader oldFilmShader;

    public float OldFilmEffectAmount = 1.0f;

    public Color sepiaColor = Color.white;
    public Texture2D vigentteTexture;
    public float vigentteAmount = 1.0f;

    public Texture2D scratchesTexture;
    public float scratchesYspeed = 10.0f;
    public float scratchesXspeed = 10.0f;

    public Texture2D dustTexture;
    public float dustYSpeed = 10.0f;
    public float dustXSpeed = 10.0f;

    private Material curMaterial;
    private float randomValue;
    #endregion

    #region Properties
    public Material material
    {
        get
        {
            if (curMaterial == null)
            {
                curMaterial = new Material(oldFilmShader);
                curMaterial.hideFlags = HideFlags.HideAndDontSave;
            }
            return curMaterial;
        }
    }
    #endregion
    void OnRenderImage(RenderTexture sourceTex, RenderTexture destTex)
    {
        if (oldFilmShader != null)
        {
            material.SetColor("_SepiaColor", sepiaColor);
            material.SetFloat("_VigentteAmount", vigentteAmount);
            material.SetFloat("_OldFilmEffectAmount", OldFilmEffectAmount);
            if (vigentteTexture)
            {
                material.SetTexture("_VigentteTex", vigentteTexture);

            }
            if (scratchesTexture)
            {
                material.SetTexture("_ScratchesTex", scratchesTexture);
                material.SetFloat("_ScratchesYSpeed", scratchesYspeed);
                material.SetFloat("_ScratchesXSpeed", scratchesXspeed);
            }
            if (dustTexture)
            {
                material.SetTexture("_DustTex", dustTexture);
                material.SetFloat("_DustXSpeed", dustXSpeed);
                material.SetFloat("_DustYSpeed", dustYSpeed);
                material.SetFloat("_RandomValue", randomValue);

            }
            Graphics.Blit(sourceTex, destTex, material);
        }
        else
        {
            Graphics.Blit(sourceTex, destTex);
        }
    }



    // Use this for initialization
    void Start()
    {
        if (SystemInfo.supportsImageEffects == false)
        {
            enabled = false;
            return;
        }

        if (oldFilmShader != null && oldFilmShader.isSupported == false)
        {
            enabled = false;
        }
    }

    // Update is called once per frame
    void Update()
    {
        vigentteAmount = Mathf.Clamp01(vigentteAmount);
        OldFilmEffectAmount = Mathf.Clamp(OldFilmEffectAmount, 0f, 1.5f);
        randomValue = Random.Range(-1f, 1f);
    }
}
