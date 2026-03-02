```rust
let jni_name = env.new_string(&karlsruhe.name).unwrap();

let jni_populations = env
    .new_int_array(karlsruhe.district_populations.len() as i32)
    .unwrap();

env.set_int_array_region(&jni_populations, 0, &karlsruhe.district_populations)
    .unwrap();

let jni_district_areas = env
    .new_float_array(karlsruhe.district_areas.len() as i32)
    .unwrap();

env.set_float_array_region(&jni_district_areas, 0, &karlsruhe.district_areas)
    .unwrap();
```
