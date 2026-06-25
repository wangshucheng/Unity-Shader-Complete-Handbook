# Effect

Post-processing effects, visual effects, and advanced shader examples merged from UnityShader projects.

## File Overview

- **Location:** Assets/Effect/FromUnityShader
- **Total files:** 96
- **Shaders:** 23
- **C# Scripts:** 8

## Subfolders / Files

- **GodRay** (10 files, 4 shaders, 3 scripts)
- **death** (2 files, 1 shaders, 1 scripts)
- **embossment** (4 files, 1 shaders, 0 scripts)
- **fluid** (6 files, 2 shaders, 0 scripts)
- **oldFilm** (5 files, 1 shaders, 1 scripts)
- **outline** (2 files, 1 shaders, 0 scripts)
- **shader_for_unity-master** (62 files, 11 shaders, 3 scripts)
- **sprite** (3 files, 1 shaders, 0 scripts)
- **water** (2 files, 1 shaders, 0 scripts)

## Main Effects

- Fluid / Water / Old film / Death / Embossment / Outline / Sprite sheet animation
- GodRay post-processing stack and skin/plant/fur/terrain advanced shaders

## Compatibility Notes

- Shaders use Unity's Built-in Render Pipeline (CG/HLSL).
- Some files include `meta.meta` legacy Unity meta entries; they are preserved for compatibility.
- Old UnityScript (`.js`) files have been removed where possible.

## Notes / Cautions

- Duplicate internal shader names have been renamed to avoid conflicts (e.g., `Custom/FluidEffect`, `Custom/SpriteEffect`).
- Please verify material references after renaming shaders if you open the project in Unity.
