check_string <- function(x, null = FALSE) {
  if (null && is.null(x)) return()
  check <- is.character(x)
  if (!check) {
    stop(sprintf("%s must be a character vector.", obj_name(x)))
  }
}


check_integerish <- function(x, null = FALSE) {
  if (null && is.null(x)) return()
  x <- as.double(x)
  check <- identical(x, round(x))
  if (!check) {
    stop(sprintf("%s must be a whole number.", obj_name(x)))
  }
}


check_class <- function(x, cls, null = FALSE) {
  if (null && is.null(x)) return()
  check <- inherits(x, cls)
  if (!check) {
    stop(sprintf("%s must inherit from class %s.", obj_name(x), cls))
  }
}


check_date <- function(x, null = FALSE) {
  if (null && is.null(x)) return()
  check <- inherits(x, "POSIXt")
  if (!check) {
    stop(sprintf(
      "%s must be a date-time object, not %s",
      obj_name(x),
      class(x)
    ))
  }
}


check_loadable <- function(pkg, purpose = NULL) {
  cond <- loadable(pkg)
  if (!cond) {
    cli::cli_abort(c(
      "Package {.pkg {pkg}} is required but not installed.",
      "i" = if (!is.null(purpose)) "It is required to {purpose}."
    ))
  }
}
