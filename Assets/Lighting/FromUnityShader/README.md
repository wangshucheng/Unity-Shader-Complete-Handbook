# Lighting

Lighting model examples including diffuse vertex and pixel shaders.

## File Overview

- **Location:** Assets/Lighting/FromUnityShader
- **Total files:** 8
- **Shaders:** 2
- **C# Scripts:** 0

## Subfolders / Files

- **book** (8 files, 2 shaders, 0 scripts)

## Main Effects

- Diffuse vertex / pixel lighting examples from the shader book

## Compatibility Notes

- Shaders use Unity's Built-in Render Pipeline (CG/HLSL).
- Some files include `meta.meta` legacy Unity meta entries; they are preserved for compatibility.
- Old UnityScript (`.js`) files have been removed where possible.

## Notes / Cautions

- Duplicate internal shader names have been renamed to avoid conflicts (e.g., `Custom/FluidEffect`, `Custom/SpriteEffect`).
- Please verify material references after renaming shaders if you open the project in Unity.
