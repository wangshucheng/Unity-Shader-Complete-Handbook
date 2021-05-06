using UnityEngine;

public class ShadowMap : MonoBehaviour
{
    Camera _camera;

    RenderTexture _rt;

    void Start()
    {
        _camera = GetComponent<Camera>();

        _rt = new RenderTexture(1024, 1024, 0);
        _rt.wrapMode = TextureWrapMode.Clamp;
        _camera.targetTexture = _rt;
        //只有tag包含"RenderType"的shader才会被应用
        _camera.SetReplacementShader(Shader.Find("test"), "RenderType");
    }

    void Update()
    {

        Matrix4x4 worldToView = _camera.worldToCameraMatrix;
        //这个接口是为了处理OpenGL跟DirectX的坐标系差异，统一换成OpenGL的坐标系，如果矩阵要用于生成RT，最好用true
        //部分机型会受到影响
        Matrix4x4 projection = GL.GetGPUProjectionMatrix(_camera.projectionMatrix, true);
        Matrix4x4 lightProjecionMatrix = projection * worldToView;
        Shader.SetGlobalMatrix("_LightProjection", lightProjecionMatrix);
        Shader.SetGlobalTexture("_LightDepthTex", _rt);
        _camera.Render();
    }
}
