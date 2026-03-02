```python
def compile_jni_libs(app_name: str) -> None:
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
```
