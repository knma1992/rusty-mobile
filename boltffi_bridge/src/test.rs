use boltffi::{data, export};

#[export]
pub fn boltffi_add(left: i32, right: i32) -> i32 {
    left + right
}

#[data]
pub struct BoltffiCity {
    pub name: String,
    pub population: i32,
    pub area: f32,
    pub is_capital: bool,
    pub district_populations: Vec<i32>,
    pub district_areas: Vec<f32>,
}

#[export]
pub fn get_karlsruhe_boltffi() -> BoltffiCity {
    let karlsruhe = BoltffiCity {
        name: String::from("Karlsruhe"),
        population: 308436,
        area: 173.46,
        is_capital: false,
        district_populations: vec![21000, 18500, 15200, 32000, 28700, 19800, 24500, 17300],
        district_areas: vec![12.3, 8.7, 15.1, 22.4, 18.9, 11.2, 9.8, 14.6],
    };
    karlsruhe
}
