using UnityEngine;
using System.Collections;

public class GodrayEffect : ImageEffectBase
{
    public enum TYPE
    {
        TYPE_BASE,
        TYPE_GODRAY
    }

    public int screenWidth = 30;
	public int screenHeight= 25;

    public float amplitude = 0;

    public RenderTexture tempRtA = null;
    public RenderTexture tempRtB = null;

    public Material ComposeMaterial;

    public Shader replaceShader;

    public TYPE type = TYPE.TYPE_GODRAY;

    // Use this for initialization
    void Awake()
    {
        if (!gameObject.GetComponent(typeof(Camera)))
            gameObject.AddComponent(typeof(Camera));
        Camera reflectCamera = gameObject.GetComponent<Camera>();

        reflectCamera.backgroundColor = new Color(0, 0, 0, 0);
        reflectCamera.clearFlags = CameraClearFlags.SolidColor;
        reflectCamera.enabled = true;
    }

    void OnPreCull()
    {
        gameObject.GetComponent<Camera>().SetReplacementShader(replaceShader, "GodRayEffect");
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (type == TYPE.TYPE_BASE)
        {
            Graphics.Blit(source, destination);
            return;
        }

        CreateBuffers();

        Graphics.Blit(source, tempRtA, material);
        Graphics.Blit(tempRtA, tempRtB, material);
        Graphics.Blit(tempRtB, tempRtA, material);
        Graphics.Blit(tempRtA,tempRtB , material);
        Graphics.Blit(tempRtB, tempRtA, material);

        Graphics.Blit(tempRtA, destination, ComposeMaterial, 0);
    }

    void CreateBuffers()
    {
        if (!tempRtA)
        {
            tempRtA = new RenderTexture(Screen.width / 4, Screen.height / 4, 0);
            tempRtA.hideFlags = HideFlags.DontSave;
        }

        if (!tempRtB)
        {
            tempRtB = new RenderTexture(Screen.width / 4, Screen.height / 4, 0);
            tempRtB.hideFlags = HideFlags.DontSave;
        }
    }


    void CustomGraphicsBlit(RenderTexture source, RenderTexture GodRayTexture, RenderTexture dest, Material BlendMaterial)
    {
		RenderTexture.active = dest;

        BlendMaterial.SetTexture("_MainTex", source);

        BlendMaterial.SetTexture("_GodRayTex", GodRayTexture);

        //BlendMaterial.SetFloat("amplitude", amplitude); //Mathf.Abs(Mathf.Sin(Time.time)));

        float m_width = 1.0f / (float)screenWidth;
        float m_height = 1.0f / (float)screenHeight;
	        	        
		GL.PushMatrix ();
		GL.LoadOrtho ();

        BlendMaterial.SetPass(0);

	    GL.Begin (GL.QUADS);

		for(int  i = 0;i<screenWidth;i++)
		{
            for (int j = 0; j < screenHeight; j++)
		  {   
              {
                  GL.MultiTexCoord2(0, m_width * (i + 1), m_height * j);
                  GL.Vertex3(m_width * (i + 1), m_height * j, -1.0f); // BR 

                  GL.MultiTexCoord2(0, m_width * i, m_height * j);
                  GL.Vertex3(m_width * i, m_height * j, -1.0f); // BL 


                  GL.MultiTexCoord2(0, m_width * i, m_height * (j + 1));
                  GL.Vertex3(m_width * i, m_height * (j + 1), -1.0f); // TL


                  GL.MultiTexCoord2(0, m_width * (i + 1), m_height * (j + 1));
                  GL.Vertex3(m_width * (i + 1), m_height * (j + 1), -1.0f); // TR  
 
              }

		  }
		}
		
		GL.End ();
	    GL.PopMatrix ();
	}		
}
