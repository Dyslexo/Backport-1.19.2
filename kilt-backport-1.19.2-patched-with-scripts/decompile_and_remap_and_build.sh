#!/usr/bin/env bash
set -euo pipefail
# Comprehensive local script to decompile, remap, and build the Kilt backport to 1.19.2.
# REQUIREMENTS (install locally):
#  - Java 17 (java on PATH)
#  - Gradle (or use Gradle wrapper provided by your environment)
#  - tiny-remapper.jar and tiny-mappings-parser jars (download from Fabric tools)
#  - Fabric FernFlower jar (you already uploaded one to this environment; place local copy at FERNFLOWER_JAR)
#  - unzip, zip, jar utilities
#
# Paths (edit these to match your local filesystem)
FERNFLOWER_JAR="/mnt/data/f7396b01-194c-47fe-84ab-89d037daa195.jar"
EXTRACTED_DIR="./kilt-extracted"            # point to the folder created by extracting the original JAR
INPUT_JAR="./kilt-extracted-input.jar"
DECOMPILE_DIR="./decompiled_src"
SKELETON_DIR="./kilt-backport-1.19.2-patched"
REMAPPED_SRC_DIR="./remapped_src"
TINy_REMAPPER_JAR="./tiny-remapper.jar"    # download and update this path
MAPPINGS_TINY="$SKELETON_DIR/src/main/resources/kilt_workaround_mappings.tiny"

echo "1) Create input jar from extracted files (skips META-INF/jars to avoid embedding other jars)"
cd "$EXTRACTED_DIR"
zip -r "$INPUT_JAR" . -x "META-INF/jars/*"
cd - > /dev/null

echo "2) Decompile using FernFlower (QuiltFlower)"
mkdir -p "$DECOMPILE_DIR"
java -cp "$FERNFLOWER_JAR" org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler "$INPUT_JAR" "$DECOMPILE_DIR"

echo "3) Prepare Fabric project skeleton"
cp -r "$SKELETON_DIR" ./kilt-build-work
cd kilt-build-work

echo "4) Copy decompiled sources into project"
rm -rf src/main/java/*
cp -r "../$DECOMPILE_DIR"/* src/main/java/ || true

echo "5) Run TinyRemapper to remap names from 1.20.1 -> 1.19.2 (if you have tiny-remapper jar)"
if [ -f "$TINy_REMAPPER_JAR" ]; then
  mkdir -p ../"$REMAPPED_SRC_DIR"
  echo "Running tiny-remapper (you need tiny-remapper.jar and mapping files)"
  # Example invocation -- adjust classpath and options for your tiny-remapper tool version
  java -jar "$TINy_REMAPPER_JAR" --input src/main/java --mappings "$MAPPINGS_TINY" --output ../"$REMAPPED_SRC_DIR"
  # After remap, copy remapped files back
  rm -rf src/main/java/*
  cp -r ../"$REMAPPED_SRC_DIR"/* src/main/java/ || true
else
  echo "tiny-remapper.jar not found at $TINy_REMAPPER_JAR — skipping remap. Build may fail and will need manual fixes."
fi

echo "6) Build with Gradle"
# Use gradle wrapper if present or local gradle
if [ -x "./gradlew" ]; then
  ./gradlew build --stacktrace
else
  gradle build --stacktrace
fi

echo "Build finished. Look for build/libs/*.jar (the remapped, compiled mod)"
