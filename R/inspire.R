#' Generate INSPIRE IDs
#' @description
#' Given pairs of coordinates, generates their INSPIRE grid representation.
#' Given INSPIRE identifiers, can also extract the X and Y coordinates.
#'
#' An INSPIRE ID contains information about the CRS, cell size and the
#' ETRS89-LAEA coordinates of the south-west corner of the grid cell in its
#' format. Only the relevant first digits are used in place of the full
#' coordinates. In case of \code{res = "100km"}, these are the first two
#' digits, for \code{res = "100m"} the first five digits.
#'
#' \preformatted{CRS3035{cellsize}mN{y}E{x} # new format
#' {cellsize}N{y}E{x}         # legacy format}
#'
#' The legacy format always uses meters while the legacy formats aggregates
#' cell sizes greater or equal to 1000m to km.
#'
#' @param coords A list, matrix, or dataframe where the X and Y coordinates are
#' either in the columns \code{"x"} and \code{"y"} or in the first and second
#' column position, respectively. Column names are converted to lowercase.
#'
#' Can also be a \code{sf}/\code{sfc} object in which case the coordinates are
#' extracted using \code{\link[sf]{st_coordinates}}.
#' @param res Resolution of the grid. Can be \code{"100m"}, \code{"250m"},
#' \code{"1km"}, \code{"5km"}, \code{"10km"}, or \code{"100km"}. If
#' \code{NULL}, tries to guess the resolution from the provided coordinates.
#' @param legacy If \code{TRUE}, generates legacy INSPIRE ID. Defaults to
#' \code{FALSE}.
#' @returns \code{z22_inspire_generate} returns a character vector containing
#' the INSPIRE identifiers. \code{z22_inspire_extract} returns a dataframe
#' or \code{\link[sf:st_sfc]{sfc}} object containing the points extracted from
#' the INSPIRE identifiers. Note that the returned coordinates are always
#' the centers of the grid cells as opposed to the south-west corners.
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
#' @name inspire
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' # Generate IDs from a dataframe
#' coords <- tibble(x = c(4334150, 4334250), y = c(2684050, 2684050))
#' z22_inspire_generate(coords) |>
#'   z22_inspire_extract() |>
#'   identical(coords)
#'
#' # Extract coordinates from legacy ID strings
#' z22_inspire_extract("100mN34000E44000")
#'
#' # Generate IDs from an sf dataframe
#' if (requireNamespace("sf", quietly = TRUE)) {
#'   coords <- sf::st_as_sf(coords, coords = c("x", "y"))
#'   z22_inspire_generate(coords)
#' }
z22_inspire_generate <- function(coords, res = NULL, legacy = FALSE) {
  if (inherits(coords, c("sf", "sfc"))) {
    coords <- sf::st_coordinates(coords)
  }

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

  if (is.null(res)) {
    res <- guess_resolution(x, y)
  } else {
    res <- res_to_m(res)
  }

  x <- trunc(x / res)
  y <- trunc(y / res)

  if (legacy) {
    res <- m_to_res(res)
    sprintf("%sN%sE%s", res, y, x)
  } else {
    sprintf("CRS3035RES%smN%sE%s", res, y, x)
  }
}


#' @name inspire
#' @param inspire A vector of INSPIRE IDs. Can be either legacy or non-legacy.
#' @param as_sf Whether to return an object of class \code{sfc} or a tibble.
#' @export
z22_inspire_extract <- function(inspire, as_sf = FALSE) {
  if (all(startsWith(inspire, "CRS"))) {
    parsed <- utils::strcapture(
      "^CRS([0-9]+)RES([0-9]+)mN([0-9]+)E([0-9]+)$",
      x = inspire,
      proto = list(crs = integer(), res = numeric(), y = integer(), x = integer())
    )
  } else {
    parsed <- utils::strcapture(
      "^([0-9]+k?m)N([0-9]+)E([0-9]+)$",
      x = inspire,
      proto = list(res = character(), y = integer(), x = integer())
    )
    parsed$res <- res_to_m(parsed$res)
  }

  parsed$x <- parsed$x * parsed$res + parsed$res / 2
  parsed$y <- parsed$y * parsed$res + parsed$res / 2

  if (as_sf) {
    crs <- unique(parsed$crs)

    if (is.null(crs)) {
      crs <- 3035
    }

    if (length(crs) > 1) {
      cli::cli_warn("More than one CRS parsed. Taking the first one.")
      crs <- crs[1]
    }

    parsed <- sf::st_as_sf(parsed, coords = c("x", "y"), crs = crs)
    sf::st_geometry(parsed)
  } else {
    dplyr::tibble(parsed[c("x", "y")])
  }
}


guess_resolution <- function(x, y) {
  x <- x[1:2000] # take a sample
  y <- y[1:2000]
  diff_x <- diff(sort(x))
  diff_y <- diff(sort(y))
  diff_x <- diff_x[!diff_x == 0]
  diff_y <- diff_y[!diff_y == 0]
  dist <- stats::median(c(diff_x, diff_y))

  if (!dist %in% res_to_m(grid_reses)) {
    cli::cli_abort(c(
      "Provided coordinates are not properly aligned in a supported grid.",
      "i" = "Supported grid resolutions are {.val {grid_reses}}."
    ))
  }

  dist
}


res_to_m <- function(res) {
  is_km <- grepl("(?<=[0-9])km", res, perl = TRUE)
  numbers <- as.numeric(regex_match(res, "^[0-9]+", i = 1))
  numbers <- ifelse(is_km, numbers * 1000, numbers)
  numbers
}


m_to_res <- function(m) {
  if (m >= 1000) {
    sprintf("%skm", m / 1000)
  } else {
    sprintf("%sm", m)
  }
}


grid_reses <- c("100m", "250m", "1km", "10km", "100km")
