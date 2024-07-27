#' @export
format.z22_metadata <- function(x, ...) {
  fmt <- lapply(names(x), function(key) {
    val <- x[[key]]
    if (is.list(val)) {
      val <- lapply(val, "%||%", "N/A")
      fmt1 <- paste0(key, ":\n")
      fmt2 <- paste0(" - ", names(val), ": ", unlist(val))
      fmt2 <- paste(fmt2, collapse = "\n")
      fmt <- paste0(fmt1, fmt2)
    } else {
      val <- val %||% "N/A"
      fmt <- paste0(key, ": ", val)
      fmt <- paste(strwrap(fmt, exdent = 2), collapse = "\n")
    }
  })
  paste(fmt, collapse = "\n")
}


#' @export
print.z22_metadata <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}
