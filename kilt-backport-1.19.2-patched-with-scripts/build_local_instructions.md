Kilt 1.20.1 -> 1.19.2 Backport Local Build Instructions
======================================================

What you already have in this repo:
 - Project skeleton with heuristic mixin patches: /mnt/data/kilt-backport-1.19.2-patched
 - kilt_workaround_mappings.tiny included under: src/main/resources/
 - AUTO_BACKPORT_INSTRUCTIONS.md (also included)

Prerequisites (install locally):
 - Java 17 (JDK)
 - Gradle or the Gradle wrapper (./gradlew)
 - FernFlower / QuiltFlower decompiler JAR (you uploaded one; keep a copy locally)
 - TinyRemapper (tiny-remapper.jar) and tiny-mappings-parser (if you plan to run automated remap)
 - Optional: yarn mappings for 1.19.2 (net.fabricmc:yarn:1.19.2+build.1)

High-level steps (automated script provided):
 1. Extract original mod JAR into a folder called `kilt-extracted` (or use provided extracted zip)
 2. Run the script `decompile_and_remap_and_build.sh` (edit paths at top to match your local FS)
 3. If build fails, copy and paste the full stdout/stderr here and I will provide exact diffs to fix compilation issues.
 4. After build succeeds, resulting jars will be in `kilt-build-work/build/libs/`

If you prefer the source-level backport route (cleaner), provide the GitHub repo ZIP or allow me to fetch it and I'll patch the code directly.
