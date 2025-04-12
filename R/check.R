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
  check_string(res)
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


check_feature <- function(feature, year, res, null = FALSE) {
  if (null && is.null(feature)) return()
  feature_row <- features[features$name %in% feature, ]
  tip <- c("i" = "See `z22_features()` for a list of available features.")

  if (year == 2011 && is.na(feature_row[[sprintf("z11_%s", res)]])) {
    cli::cli_abort(c(
      paste(
        "Feature {.val {feature}} is not available at a resolution",
        "of {.val {res}} for {.val {year}}."
      ),
      tip
    ))
  } else if (year == 2022 && is.na(feature_row$z22)) {
    cli::cli_abort(c(
      "Feature {.val {feature}} is not available for {.val {year}}.",
      tip
    ))
  }
}


check_category <- function(categories, feature, null = FALSE) {
  if (null && is.null(feature)) return()
  cat_df <- z22_categories(feature)

  for (cat in categories) {
    if (!cat %in% cat_df$code) {
      cli::cli_abort(c(
        "Category code {.val {cat}} not available for feature {.val {feature}}.",
        "i" = "See `z22_category(\"{feature}\")` for a list of available features."
      ))
    }
  }
}


check_normalize <- function(normalize, feature) {
  type <- features[features$name %in% feature, ]$type

  if (normalize && type %in% c("share", "average")) {
    cli::cli_abort(paste(
      "Can only normalize (= compute shares) absolute counts,",
      "not from shares or averages."
    ))
  }
}
