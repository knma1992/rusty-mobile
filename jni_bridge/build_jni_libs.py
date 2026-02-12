import shutil
import subprocess
from pathlib import Path

RUST_PATH = Path(__file__).parent.resolve()
REPO_PATH = RUST_PATH.parent


def compile_jni_libs(app_name: str) -> None:
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


def main():
    compile_jni_libs(app_name="rusty_droid")


if __name__ == "__main__":
    main()
