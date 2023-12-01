typed::Data.frame() ? test

cassert <- typed::as_assertion_factory(function(
  value
) {

  value

})

#' @title test_assert
#' @name foo
#' @description foo
#'
#' @return test
#' @export
test_assert <- typed::Integer() ? function() {
  cassert() ? custom_var
  custom_var <- as.integer(1)
  custom_var
}