#[extendr_api::prelude::extendr]
fn test_x(x: i32) {
    if x > 0 {
        cov_mark::hit!(positive);
    } else {
        cov_mark::hit!(negative);
    }

}

#[cfg(test)]
mod tests {
  use extendr_api::prelude::*;
  #[test]
  fn test_covmark() {
    test! {
        cov_mark::check!(positive);
        let _ = crate::test_x(1);
    }
  }
}