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


regex_match <- function (text, pattern, i = NULL, ...) {
  match <- regmatches(text, regexec(pattern, text, ...))
  if (!is.null(i)) {
    match <- vapply(match, FUN.VALUE = character(1), function(x) {
      if (length(x) >= i) {
        x[[i]]
      } else {
        NA_character_
      }
    })
  }
  match
}


rename <- function(.data, ...) {
  new <-   loc <- list(...)
  loc <- match(names(new), names(.data))
  names <- names(.data)
  names[loc] <- new
  names(.data) <- unlist(names)
  .data
}


move_to_front <- function(.data, which) {
  cols <- names(.data)[which]
  other_cols <- setdiff(names(.data), cols)
  .data[c(cols, other_cols)]
}


na_tbl <- function(names) {
  tb <- do.call(
    dplyr::tibble,
    c(as.list(rep(NA, length(names))), .name_repair = "minimal")
  )
  names(tb) <- names
  tb
}
