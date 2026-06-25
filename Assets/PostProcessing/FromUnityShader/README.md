# PostProcessing

Screen-space post-processing and anti-aliasing filters merged from UnityShader projects.

## File Overview

- **Location:** Assets/PostProcessing/FromUnityShader
- **Total files:** 84
- **Shaders:** 22
- **C# Scripts:** 3

## Subfolders / Files

- **oldFilm** (1 files, 1 shaders, 0 scripts)
- **shader_for_unity-master** (83 files, 21 shaders, 3 scripts)

## Main Effects

- SSAA, FXAA, HDR/Bloom, depth of field, barrel/fisheye distortion, CRT/scanline retro filters
- Computer fault glitch effect and real-time denoising filters

## Compatibility Notes

- Shaders use Unity's Built-in Render Pipeline (CG/HLSL).
- Some files include `meta.meta` legacy Unity meta entries; they are preserved for compatibility.
- Old UnityScript (`.js`) files have been removed where possible.

## Notes / Cautions

- Duplicate internal shader names have been renamed to avoid conflicts (e.g., `Custom/FluidEffect`, `Custom/SpriteEffect`).
- Please verify material references after renaming shaders if you open the project in Unity.
