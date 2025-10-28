#' Generate INSPIRE IDs
#' @description
#' Given pairs of coordinates, generates their INSPIRE grid representation.
#' Given INSPIRE identifiers, can also extract the X and Y coordinates.
#'
#' An INSPIRE ID contains information about the CRS, cell size and the
#' ETRS89-LAEA coordinates of the south-west corner of the grid cell in its
#' format.
#'
#' \preformatted{CRS3035RES{cellsize}mN{y}E{x} # long format
#' {cellsize}N{y}E{x}         # short format}
#'
#' The short format always uses meters while the short formats aggregates
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
#' @param short If \code{TRUE}, generates short INSPIRE IDs. Defaults to
#' \code{FALSE}.
#' @param llc Do the coordinates in \code{coords} represent the lower-left
#' corners of their cells? If \code{FALSE}, subtracts each coordinate by
#' half of \code{res}. If \code{TRUE}, leaves them as-is. Defaults
#' to \code{FALSE}, i.e., treat coordinates as cell centroids.
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
#' identical(z22_inspire_extract(z22_inspire_generate(coords))[c("x", "y")], coords)
#'
#' # Extract coordinates from short ID strings
#' z22_inspire_extract("100mN34000E44000")
#'
#' # Generate IDs from an sf dataframe
#' if (requireNamespace("sf", quietly = TRUE)) {
#'   coords <- sf::st_as_sf(coords, coords = c("x", "y"), crs = 3035)
#'   z22_inspire_generate(coords)
#' }
z22_inspire_generate <- function(coords,
                                 res = NULL,
                                 short = FALSE,
                                 llc = FALSE) {
  if (inherits(coords, c("sf", "sfc"))) {
    coords <- sf::st_transform(coords, 3035)
    coords <- sf::st_coordinates(coords)
  }

  if (is.matrix(coords)) {
    coords <- as.data.frame(coords)
  }

  if (!nrow(coords)) {
    cli::cli_abort("Argument `coords` cannot be empty.")
  }

  colnames(coords) <- tolower(colnames(coords))
  x <- coords[["x"]]
  y <- coords[["y"]]

  if (is.null(x) || is.null(y)) {
    x <- coords[[1]]
    y <- coords[[2]]
  }

  if (any(is.na(x)) || any(is.na(y))) {
    cli::cli_abort("Argument `coords` contains missing values in the coordinates.")
  }

  if (is.null(res)) {
    res <- guess_resolution(x, y)
  } else {
    res <- res_to_m(res)
  }

  if (!llc) {
    x <- x - res / 2
    y <- y - res / 2
  }

  if (short) {
    x <- trunc(x / res)
    y <- trunc(y / res)
    res <- m_to_res(res)
    sprintf("%sN%.0fE%.0f", res, y, x)
  } else {
    sprintf("CRS3035RES%.0fmN%.0fE%.0f", res, y, x)
  }
}


#' @name inspire
#' @param inspire A vector of INSPIRE IDs. Can be either short or long format.
#' @param as Specifies the output class. Must be one of \code{"df"} or
#' \code{"sf"}. If \code{"df"} (default), returns flat
#' coordinates in a dataframe. If \code{"sf"} (and the \code{sf} package is
#' installed), converts the coordinates to an \code{sf} tibble.
#' @param meta Whether to include parsed CRS and resolution in the output.
#' If \code{FALSE}, output contains only coordinates. If \code{TRUE}, also
#' contains columns \code{"crs"} and \code{"res"}.
#' @export
z22_inspire_extract <- function(inspire, as = c("df", "sf"), meta = FALSE) {
  as <- match.arg(as)

  if (!is.character(inspire) && !length(inspire) > 0) {
    cli::cli_abort("Argument `inspire` must be a character vector with more than one value.")
  }

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

    # add truncated zeroes
    parsed$x <- parsed$x * parsed$res
    parsed$y <- parsed$y * parsed$res
  }

  # LLCs to centroids
  parsed$x <- parsed$x + parsed$res / 2
  parsed$y <- parsed$y + parsed$res / 2

  switch(
    as,

    sf = {
      crs <- unique(parsed$crs)

      if (is.null(crs)) {
        crs <- 3035
      }

      if (length(crs) > 1) {
        cli::cli_abort("INSPIRE identifiers contain more than one CRS.")
      }

      if (!meta) {
        parsed <- parsed[c("x", "y")]
      }

      sf::st_as_sf(parsed, coords = c("x", "y"), crs = crs)
    },

    df = dplyr::tibble(parsed[c(if (meta) c("crs", "res"), "x", "y")])
  )
}


guess_resolution <- function(x, y, sample = 2000, tolerance = 1e-6) {
  sample <- min(sample, length(x))
  x <- x[seq(1, sample)]
  y <- y[seq(1, sample)]
  diff_x <- diff(sort(x))
  diff_y <- diff(sort(y))
  diff_x <- diff_x[!diff_x == 0]
  diff_y <- diff_y[!diff_y == 0]

  if (!length(diff_x) && !length(diff_y)) {
    cli::cli_abort(
      "Cannot determine resolution: not enough unique coordinates to form a grid."
    )
  }

  res_x <- stats::median(diff_x)
  res_y <- stats::median(diff_y)

  if (!is.na(res_x) && any(abs(diff_x - res_x) > tolerance)) {
    cli::cli_abort("Coordinates have non-uniform spacing in the X dimension.")
  }

  if (!is.na(res_y) && any(abs(diff_y - res_y) > tolerance)) {
    cli::cli_abort("Coordinates have non-uniform spacing in the Y dimension.")
  }

  if (!is.na(res_x) && !is.na(res_y) && abs(res_x - res_y) > tolerance) {
    cli::cli_abort("Coordinates form an anisotropic grid. X and Y coordinates have a different resolution.")
  }

  res_x
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
