using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class d_cubMap : MonoBehaviour
{
    public Cubemap cubmap;
    public Camera cam;
    private Material curMat;
    // Use this for initialization


    void Awake()
    {
        cubmap = new Cubemap(512, TextureFormat.ARGB32, false);
    }

    void Start()
    {
        InvokeRepeating("UpdateChange", 1, 0.1f);
        curMat = GetComponent<Renderer>().sharedMaterial;
    }
    void UpdateChange()
    {
        cam.transform.rotation = Quaternion.identity;
        cam.RenderToCubemap(cubmap);

        curMat.SetTexture("_Cubemap", cubmap);
    }

}
