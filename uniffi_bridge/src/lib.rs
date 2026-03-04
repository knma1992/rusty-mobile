use crate::uniffi_city::UniffiCity;

uniffi::setup_scaffolding!();

pub mod uniffi_city;

#[uniffi::export]
pub fn uniffi_add(left: i32, right: i32) -> i32 {
    left + right
}

#[uniffi::export]
pub fn get_karlsruhe_uniffi() -> UniffiCity {
    let karlsruhe = UniffiCity {
        name: String::from("Karlsruhe"),
        population: 308436,
        area: 173.46,
        is_capital: false,
        district_populations: vec![21000, 18500, 15200, 32000, 28700, 19800, 24500, 17300],
        district_areas: vec![12.3, 8.7, 15.1, 22.4, 18.9, 11.2, 9.8, 14.6],
    };
    karlsruhe
}
