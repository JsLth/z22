z22_inspire_generate <- function(coords, res = c("100m", "1km")) {
  res <- match_arg(res)
  x <- coords[["x"]]
  y <- coords[["y"]]

  if (is.null(x) || is.null(y)) {
    x <- coords[[1]]
    y <- coords[[2]]
  }

  sprintf("%sN%sE%s", res, substr(y, 1, 5), substr(x, 1, 5))
}
