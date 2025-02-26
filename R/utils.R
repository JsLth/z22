"%|||%" <- function(x, y) if (is.null(x) || all(is.na(x))) y else x

"%||%" <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}


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

  if (missing(choices)) {
    parent <- sys.parent()
    args <- formals(sys.function(parent))
    choices <- eval(
      args[[as.character(substitute(arg))]],
      envir = sys.frame(parent)
    )
  }

  match.arg(arg = arg, choices = choices, several.ok = several.ok)
}


loadable <- function(x) {
  requireNamespace(x, quietly = TRUE)
}

