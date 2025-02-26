#' Generate INSPIRE IDs
#' @description
#' Given pairs of coordinates, generates their INSPIRE grid representation.
#' An INSPIRE ID contains both the cell size and the ETRS89-LAEA coordinates
#' of the south-west corner of the grid cell in the format
#' \code{\{cellsize\}N\code{\{x_coord\}}E\code{\{y_coord\}}}. Only the first
#' four digits of the coordinates are used in the identifier.
#'
#' @param coords A list, matrix, or dataframe where the X and Y coordinates are
#' either in the columns \code{"x"} and \code{"y"} or in the first and second
#' column position, respectively. Column names are converted to lowercase.
#' @inheritParams z22_get_attribute
#' @returns A character vector containing the INSPIRE identifiers.
#' @export
#'
#' @details
#' To remain fast even for huge grid datasets, the function is just a very
#' simple \code{\link{sprintf}} wrapper that performs no input checks. To
#' produce valid INSPIRE identifiers, make sure to transform your data to
#' ETRS89-LAEA (e.g. using
#' \code{\link[sf:st_transform]{st_transform}(..., 3035)}). You should also
#' make sure that the coordinates are the south-west corner of existing
#' INSPIRE grid cells.
#'
#' @examples
#' # Generate IDs from a dataframe
#' coords <- data.frame(x = c(4334150, 4334250), y = c(2684050, 2684050))
#' z22_inspire_generate(coords)
#'
#' # Generate IDs from an sf dataframe
#' if (requireNamespace("sf", quietly = TRUE)) {
#'   coords <- sf::st_as_sf(coords, coords = c("x", "y"))
#'   z22_inspire_generate(sf::st_coordinates(coords))
#' }
z22_inspire_generate <- function(coords, res = c("100m", "1km")) {
  res <- match_arg(res)
  if (is.matrix(coords)) {
    coords <- as.data.frame(coords)
  }
  colnames(coords) <- tolower(colnames(coords))
  x <- coords[["x"]]
  y <- coords[["y"]]

  if (is.null(x) || is.null(y)) {
    x <- coords[[1]]
    y <- coords[[2]]
  }

  sprintf("%sN%sE%s", res, substr(y, 1, 5), substr(x, 1, 5))
}
