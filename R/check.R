check_length <- function(x, len, null = FALSE) {
  if (null && is.null(x)) return()
  check <- length(x) == len
  if (!check) {
    cli::cli_abort("{obj_name(x)} must be of length {len}.")
  }
}


check_string <- function(x, null = FALSE) {
  if (null && is.null(x)) return()
  check <- is.character(x)
  if (!check) {
    cli::cli_abort("{obj_name(x)} must be a character vector.")
  }
}


check_integerish <- function(x, null = FALSE) {
  if (null && is.null(x)) return()
  x <- as.double(x)
  check <- identical(x, round(x))
  if (!check) {
    cli::cli_abort("{obj_name(x)} must be a whole number.")
  }
}


check_class <- function(x, cls, null = FALSE) {
  if (null && is.null(x)) return()
  check <- inherits(x, cls)
  if (!check) {
    cli::cli_abort("{obj_name(x)} must inherit from class {.cls {cls}}.")
  }
}


check_date <- function(x, null = FALSE) {
  if (null && is.null(x)) return()
  check <- inherits(x, "POSIXt")
  if (!check) {
    cli::cli_abort("{obj_name(x)} must be a date-time object, not {. cls {class(x)}}.")
  }
}


check_loadable <- function(pkg, purpose = NULL) {
  cond <- loadable(pkg)
  if (!cond) {
    cli::cli_abort(c(
      "Package {.pkg {pkg}} is required but not installed.",
      "i" = if (!is.null(purpose)) "It is required to {purpose}."
    ))
  }
}


check_year <- function(year, null = FALSE) {
  if (null && is.null(year)) return()
  check_length(year, 1)
  if (!year %in% c(2011, 2022)) {
    cli::cli_abort(c(
      "Year {year} not available.",
      "i" = "Currently, there are only two census grids: 2011 and 2022."
    ))
  }
}


check_resolution <- function(res, year, null = FALSE) {
  if (null && is.null(res)) return()
  check_length(res, 1)
  if (year == 2011 && res == "10km") {
    cli::cli_abort(c(
      "For 2011, only resolutions 100m and 1km are available.",
      "i" = "See ?sf::aggregate for ways to aggregate to a coarser grid."
    ))
  }

  if (!res %in% c("100m", "1km", "10km")) {
    cli::cli_abort(c(
      "Only resolutions 100m, 1km, and 10km are available.",
      "i" = "See ?sf::aggregate for ways to aggregate to a coarser grid."
    ))
  }
}


check_theme <- function(theme, null = FALSE) {
  if (null && is.null(theme)) return()
  check_length(theme, 1)
  if (!tolower(theme) %in% tolower(features$theme)) {
    cli::cli_abort(c(
      "Theme {theme} does not exist.",
      "i" = "Available themes: {unique(overview$theme)}"
    ))
  }
}
