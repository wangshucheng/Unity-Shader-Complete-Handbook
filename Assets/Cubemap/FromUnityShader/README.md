# Cubemap

Cubemap-based reflection and environment shaders.

## File Overview

- **Location:** Assets/Cubemap/FromUnityShader
- **Total files:** 4
- **Shaders:** 1
- **C# Scripts:** 1

## Subfolders / Files

- **reflect** (4 files, 1 shaders, 1 scripts)

## Main Effects

- Simple reflection using cubemap lookup

## Compatibility Notes

- Shaders use Unity's Built-in Render Pipeline (CG/HLSL).
- Some files include `meta.meta` legacy Unity meta entries; they are preserved for compatibility.
- Old UnityScript (`.js`) files have been removed where possible.

## Notes / Cautions

- Duplicate internal shader names have been renamed to avoid conflicts (e.g., `Custom/FluidEffect`, `Custom/SpriteEffect`).
- Please verify material references after renaming shaders if you open the project in Unity.
