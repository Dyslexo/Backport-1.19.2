
AUTO BACKPORT INSTRUCTIONS - Best-effort automated steps
-------------------------------------------------------

This file contains a set of commands and a script you can run locally to attempt an automated
backport from Minecraft 1.20.1 -> 1.19.2 using the extracted JAR contents. These steps require
you to have Java (17), Gradle, and a Java decompiler (like fernflower or CFR) installed locally.

Important: This environment did NOT include a Java decompiler, so I could not decompile classes here.
These commands assume you will run them on your machine where you have tools installed.

1) Files you already have (in this folder)
   - The original mod contents (classes, resources) from the uploaded JAR.
   - Kilt.mixins.json and other mixin configs.
   - build-skeleton prepared separately at /mnt/data/kilt-backport-1.19.2.zip

2) Automated steps (outline)
   - Decompile class files to Java source using a decompiler of choice.
   - Create a Fabric Loom project for 1.19.2 and populate src/main/java with decompiled sources.
   - Replace mappings from 1.20.1 names to 1.19.2 names using yarn mapping (tiny) and TinyRemapper.
   - Fix obvious compilation errors (imports, method signatures, mixin targets).
   - Build with Gradle and test in a 1.19.2 Fabric environment.

3) Example commands (requires local tools)
   # Decompile (using CFR)
   java -jar /path/to/cfr.jar kilt-extracted.jar --outputdir decompiled_src

   # OR using fernflower (QuiltFlower)
   java -jar /path/to/quiltflower.jar kilt-extracted.jar decompiled_src

   # Create a new Fabric project and copy sources
   unzip /path/to/kilt-backport-1.19.2.zip -d kilt-backport-1.19.2
   cp -r decompiled_src/* kilt-backport-1.19.2/src/main/java/

   # Add original resources
   cp -r assets kilt-backport-1.19.2/src/main/resources/
   cp Kilt.mixins.json kilt-backport-1.19.2/src/main/resources/

   # Use TinyRemapper to remap 1.20.1 names to 1.19.2 (you'll need tiny-mappings and tiny-remapper jars)
   # This is a skeleton example; refer to TinyRemapper docs for exact commands:
   java -jar tiny-remapper.jar --input decompiled_src --mappings kilt_workaround_mappings.tiny --output remapped_src

   # Build
   cd kilt-backport-1.19.2
   ./gradlew build --stacktrace

4) Common manual fixes after remap
   - Update mixin target method descriptors (parameters/return types) to 1.19.2 equivalents.
   - Fix Accessor/Invoker mixins where field/method names changed—replace with correct yarn names.
   - Replace Fabric API calls introduced after 1.19.2 with compatible alternatives or guards.

5) Helpful tools & references
   - Yarn mappings for 1.19.2: net.fabricmc:yarn:1.19.2+build.1
   - Fabric API for 1.19.2: net.fabricmc.fabric-api:fabric-api:0.76.1+1.19.2
   - TinyRemapper / tiny-mappings-parser
   - QuiltFlower or CFR for decompilation

6) If you want, I can:
   - Produce a patch file skeleton with probable mixin target edits (best-effort) using pattern matching.
   - Attempt an automated remap of class names inside decompiled code if you supply a decompiler jar I can run here.
   - Or, if you provide the mod's GitHub repository, perform a proper backport edit into source.

---
Script & artifacts on this machine:
 - Extracted contents: /mnt/data/kilt-extracted
 - Backport project skeleton: /mnt/data/kilt-backport-1.19.2.zip
 - Extracted zip: /mnt/data/kilt-extracted.zip
