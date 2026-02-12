import shutil
import subprocess
from pathlib import Path

RUST_PATH = Path(__file__).parent.resolve()
REPO_PATH = RUST_PATH.parent


def compile_jni_libs(app_name: str, lib_name: str) -> None:
    """Compile JNI libraries using Cargo and Android NDK."""

    jni_folder_name = "jniLibs"
    subprocess.run(
        [
            "cargo",
            "ndk",
            "-t",
            "arm64-v8a",
            "-o",
            jni_folder_name,
            "-p",
            "26",
            "build",
            "--lib",
            "--release",
        ],
        cwd=RUST_PATH,
        check=True,
    )

    # Copy jniLibs to the Android Studio project
    jni_libs_src = RUST_PATH / jni_folder_name
    jni_libs_dest = REPO_PATH / app_name / "app/src/main/jniLibs"

    print(f"Copying jniLibs from {jni_libs_src} to {jni_libs_dest}")
    print("Files copied:")
    for src in jni_libs_src.glob("**/*.so"):
        dest = jni_libs_dest / src.relative_to(jni_libs_src)
        dest.parent.mkdir(parents=True, exist_ok=True)
        print(f"{src.relative_to(jni_libs_src)}")
        shutil.copy2(src, dest)

    subprocess.run(
        [
            "cargo",
            "run",
            "--bin",
            "uniffi-bindgen",
            "generate",
            "--library",
            f"target/aarch64-linux-android/release/lib{lib_name}.so",
            "--language",
            "kotlin",
            "--out-dir",
            "out",
        ],
        cwd=RUST_PATH,
        check=True,
    )

    dest = REPO_PATH / app_name / f"app/src/main/java/uniffi/{lib_name}/{lib_name}.kt"
    src = RUST_PATH / f"out/uniffi/{lib_name}/{lib_name}.kt"
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest)


def main():
    compile_jni_libs(app_name="rusty_droid", lib_name="uniffi_bridge")


if __name__ == "__main__":
    main()
