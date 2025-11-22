
Kilt backport skeleton (auto-generated)

This skeleton prepares a Fabric Loom project targeting Minecraft 1.19.2.
Files:
  - build.gradle       : initial Gradle file (tweak Loom version and loader as needed)
  - settings.gradle
  - kilt.mixins.json   : placeholder mixin config (original entries must be copied)

Next steps to complete backport (high-level):
  1. Decompile original mod to retrieve sources or get upstream source code.
  2. Replace mixin targets and accessors for 1.19.2 mappings (use yarn 1.19.2).
  3. Swap any 1.20-specific Fabric API calls with 1.19.2 equivalents.
  4. Adjust any code that relies on new Minecraft classes introduced after 1.19.2.
  5. Build with `./gradlew build` after running `genSources` and `downloadAssets`.

Local paths:
  - Original uploaded JAR: /mnt/data/ee14111a-558c-4b18-9a52-31df8c4f728e.jar

Important: this is only a scaffold. The real backport requires source-level edits.
