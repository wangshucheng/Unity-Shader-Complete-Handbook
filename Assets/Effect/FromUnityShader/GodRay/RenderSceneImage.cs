using UnityEngine;
using System.Collections;

public class RenderSceneImage : MonoBehaviour
{
    public Shader replaceShader;

	// Use this for initialization
	void Awake () {
        if (!gameObject.GetComponent(typeof(Camera)))
            gameObject.AddComponent(typeof(Camera));
        Camera reflectCamera = gameObject.GetComponent<Camera>();

        reflectCamera.backgroundColor = Color.black;
        reflectCamera.clearFlags = CameraClearFlags.SolidColor;
        reflectCamera.enabled = true;

        if (!reflectCamera.targetTexture)
            reflectCamera.targetTexture = CreateTextureFor(Camera.main, reflectCamera);


	}

    void OnPreCull()
    {
        gameObject.GetComponent<Camera>().SetReplacementShader(replaceShader, "RenderType");
    }

	// Update is called once per frame
	void Update () {

        Shader.SetGlobalTexture("_GodRayTex", GetComponent<Camera>().targetTexture);
	}



    private RenderTexture CreateTextureFor(Camera cam,Camera refcamera)
    {
        RenderTextureFormat rtFormat = RenderTextureFormat.RGB565;
        if (!SystemInfo.SupportsRenderTextureFormat(rtFormat))
            rtFormat = RenderTextureFormat.Default;

        RenderTexture rt = new RenderTexture(Mathf.FloorToInt(cam.pixelWidth / 2.0f), Mathf.FloorToInt(cam.pixelHeight / 2.0f), 24, rtFormat);
        refcamera.aspect = cam.pixelWidth / cam.pixelHeight;
        rt.hideFlags = HideFlags.DontSave;

        return rt;
    }

}
