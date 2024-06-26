obj_name <- function(x, env = parent.frame()) {
  deparse(substitute(x, env))
}


drop_null <- function(x) {
  x[!vapply(x, FUN.VALUE = logical(1), is.null)]
}


drop_empty <- function(x) {
  x[lengths(x) > 0]
}


match_arg <- function(arg, choices, several.ok = FALSE, null = TRUE) {
  if (is.null(arg) && null) return()
  match.arg(arg = arg, choices = choices, several.ok = several.ok)
}
