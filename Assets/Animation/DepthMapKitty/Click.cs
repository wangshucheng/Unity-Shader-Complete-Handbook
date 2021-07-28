using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
public class Click : MonoBehaviour
{
    private static int s_pos, s_time;
    public Material mat;

    public Shader sh;
    public float frequency = 11;
    public float duration = 20000;

    private Vector3 scalex = new Vector3(0.05f, 0.05f, 0.05f);
    private Vector3 oldPos, newPos, offset, ssize;

    private void Start()
    {
        oldPos = Input.mousePosition;
        ssize = new Vector3(Screen.width, Screen.height, 1);
    }

    void Update()
    {
        newPos = Input.mousePosition;
        offset = newPos - oldPos;

        scalex.x = (newPos.x - ssize.x * 0.5f) * 0.08f / ssize.x;
        scalex.y = (newPos.y - ssize.y * 0.5f) * 0.08f / ssize.y;

        if (scalex.x > 0.015f) scalex.x = 0.015f;
        if (scalex.x < -0.015f) scalex.x = -0.015f;
        if (scalex.y > 0.03f) scalex.y = 0.03f;
        if (scalex.y < -0.005f) scalex.y = -0.005f;

        mat.SetVector("_Scale", scalex);
        //Debug.Log(scalex);

        oldPos = newPos;
    }
}