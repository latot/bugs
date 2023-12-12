#' @keywords internal
"_PACKAGE"

## manual namespace: end
## typed vars
#' @importFrom typed ?
#' @importFrom typed check_arg
#' @importFrom typed check_output
#' @importFrom typed declare
#' @importFrom typed process_assertion_factory_dots
## manual namespace: end

NULL

# bug in magrittr/issues/29 also affects wrapr
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))