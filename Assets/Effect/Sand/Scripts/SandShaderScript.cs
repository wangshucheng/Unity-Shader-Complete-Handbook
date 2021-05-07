using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SandShaderScript : MonoBehaviour
{
    public Material sandMat;           //沙粒材质球      

    void Start()
    {
       
    }

    void Update()
    {
        if (Input.GetMouseButton(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray,out hit))
            {
                MeshRenderer[] renderers = hit.collider.GetComponentsInChildren<MeshRenderer>();
                this.sandMat.SetFloat("_StartTime", Time.timeSinceLevelLoad);

                for (int i = 0; i < renderers.Length; i++)
                {
                    renderers[i].material = this.sandMat;
                }
            }
        }
    }
}
