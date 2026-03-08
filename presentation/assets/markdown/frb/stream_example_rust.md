```rust
pub fn stream_example(
    imput_struct: InputStruct,
    sink: StreamSink<OutputStruct>,
) -> Result<()> {
    //... setup
    loop {
        //... compute

        if sink.add(outputStruct).is_err() {
            break;
        }
    }
    Ok(())
}
```
