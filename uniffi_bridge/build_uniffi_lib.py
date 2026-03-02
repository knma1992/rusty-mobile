import subprocess
from pathlib import Path

RUST_PATH = Path(__file__).parent.resolve()
REPO_PATH = RUST_PATH.parent


def compile_jni_libs(app_name: str, lib_name: str) -> None:
    """Compile JNI libraries using Cargo and Android NDK."""

    subprocess.run(
        [
            "cargo",
            "ndk",
            "-t",
            "arm64-v8a",
            "-o",
            REPO_PATH / app_name / "app/src/main/jniLibs",
            "-p",
            "26",
            "build",
            "--lib",
            "--release",
        ],
        cwd=RUST_PATH,
        check=True,
    )

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
            REPO_PATH / app_name / "app/src/main/java/",
        ],
        cwd=RUST_PATH,
        check=True,
    )


def main():
    compile_jni_libs(app_name="rusty_droid", lib_name="uniffi_bridge")


if __name__ == "__main__":
    main()
