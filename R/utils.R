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


unbox <- function(x) {
  if (length(x) == 1) {
    x <- x[[1]]
  }
  x
}


rbind_list <- function(args) {
  args <- args %||% list()
  nam <- lapply(args, names)
  unam <- unique(unlist(nam))
  len <- vapply(args, length, numeric(1))
  out <- vector("list", length(len))
  for (i in seq_along(len)) {
    if (!is.data.frame(args[[i]])) {
      args[[i]] <- as.data.frame(drop_null(args[[i]]))
    }
    if (nrow(args[[i]])) {
      nam_diff <- setdiff(unam, names(args[[i]]))
      if (length(nam_diff)) {
        args[[i]][nam_diff] <- NA
      }
    } else {
      next # nocov
    }
  }
  out <- do.call(rbind, args)
  rownames(out) <- NULL
  out
}


bind_rows <- function(..., .id = NULL) {
  dots <- unbox(list(...))
  out <- rbind_list(dots)
  if (!is.null(.id)) {
    names <- names(dots)
    nrows <- vapply(
      dots,
      function(x) nrow(x) %||% length(x),
      FUN.VALUE = numeric(1)
    )
    ids <- rep(names, times = nrows)
    ids <- data.frame(ids)
    names(ids) <- .id
    out <- cbind(ids, out)
  }

  as_df(out)
}


as_df <- function(x) {
  if (loadable("tibble")) {
    tibble::as_tibble(x)
  } else {
    as.data.frame(x)
  }
}


loadable <- function(x) {
  suppressPackageStartupMessages(suppressWarnings(requireNamespace(x)))
}
