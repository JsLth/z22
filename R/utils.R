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
