import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

RUST_JNI_PATH = Path(__file__).parent.resolve()
REPO_PATH = RUST_JNI_PATH.parent

PLATFORM = sys.platform

def find_latest_ndk(major: int) -> str:
    PLATFORM = sys.platform
    ndk_base = None
    if PLATFORM == "darwin":
        ndk_base = Path.home() / "Library/Android/sdk/ndk"
    elif PLATFORM.startswith("linux"):
        sdk_root = os.environ.get("ANDROID_SDK_ROOT") or os.environ.get("ANDROID_HOME")
        if sdk_root:
            ndk_base = Path(sdk_root) / "ndk"
        else:
            ndk_base = Path.home() / "Android/Sdk/ndk"
    elif PLATFORM == "win32":
        ndk_base = Path.home() / "AppData/Local/Android/Sdk/ndk"
    else:
        raise RuntimeError(f"Unsupported platform: {PLATFORM}")
    if not ndk_base.exists():
        raise RuntimeError(f"NDK base directory does not exist: {ndk_base}")
    ndk_versions = sorted(
        [
            v.name
            for v in ndk_base.iterdir()
            if v.is_dir() and v.name.startswith(f"{major}.")
        ],
        key=lambda s: [int(x) for x in s.split(".")],
    )
    if not ndk_versions:
        raise RuntimeError(f"No Android NDK {major}.x found in {ndk_base}")
    latest_ndk = ndk_versions[-1]
    return str(ndk_base / latest_ndk)

def compile_boltffi(major: int) -> None:

    ndk_path = find_latest_ndk(major)
    os.environ["ANDROID_NDK_HOME"] = ndk_path

    subprocess.run(
        [
            "boltffi",
            "pack",
            "android",
        ],
        cwd=RUST_JNI_PATH,
        check=True
    )

    binary_file_name = "libboltffi_bridge.so"
    generated_kotlin_file = "BoltffiBridge.kt"

    src = RUST_JNI_PATH / Path("dist/android/jniLibs/arm64-v8a") / binary_file_name
    dest = REPO_PATH / "rusty_droid/app/src/main/jniLibs/arm64-v8a"
    shutil.copy2(src, dest)

    src = RUST_JNI_PATH / Path("dist/android/kotlin/de/knma/rustydroid") / generated_kotlin_file
    dest = REPO_PATH / Path("rusty_droid/app/src/main/java/de/knma/rustydroid") / generated_kotlin_file
    shutil.copy2(src, dest)


def main():
    compile_boltffi(29)

if __name__ == "__main__":
    main()
