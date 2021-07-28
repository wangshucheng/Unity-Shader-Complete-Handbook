[toc]

# PBR
基于物理的渲染

## UnityPbrRendering
网上博主参考Unity Standard手写的PBR

## ArcHandWritePbrTexture.shader
我改写上面的，增加法线贴图和金属度贴图

## MyShader_PBRTexture.shader
另一博主实现的pbr

## AlfxPBR.shader
- 直接光照（迪士尼漫反射+NFG直接高光）
- 间接光照（球谐函数采样cubemap实现间接光漫反射+间接高光）
- 支持两套法线、漫反射贴图，支持一张粗糙度、AO、金属度贴图
- 可选开启self-shadow
- 支持各向异性