#' Cast feature grid to a long table
#' @description
#' Helper function to convert the output of \code{\link{z22_data}} to a
#' long table. This can be useful for plotting or other data wrangling tasks.
#'
#' Note that pivoting can quickly become expensive for larger 100m grids.
#'
#' @param .data Output of \code{\link{z22_data}}.
#' @param feature A grid feature that is represented by \code{.data}.
#' @inheritParams z22_decode
#' @returns A dataframe containing the columns \code{category}, \code{value},
#' \code{x} and \code{y}. All non-category columns are preserved.
#'
#' @details
#' Note that all columns starting with \code{"cat_*"} are automatically used
#' for pivoting.
#'
#' @export
#'
#' @examplesIf arrow::codec_is_available("zstd")
#' \donttest{# get feature grid
#' age <- z22_data("age_short", res = "10km")
#'
#' # pivot to a long table
#' z22_pivot_longer(age, feature = "age_short")}
z22_pivot_longer <- function(.data, feature, lang = c("english", "german")) {
  lang <- match.arg(lang)

  if (inherits(.data, "SpatRaster")) {
    rast_pivot_longer(.data, feature, lang)
  } else if (is.data.frame(.data)) {
    df_pivot_longer(.data, feature, lang)
  } else {
    cli::cli_abort("`.data` must be a SpatRaster or a (sf) dataframe.")
  }
}


rast_pivot_longer <- function(.data, feature, lang) {
  cats <- z22_categories(feature)
  .data_list <- lapply(.data, terra::as.data.frame, xy = TRUE)
  .data <- dplyr::bind_rows(.data_list, .id = "category")
  cat_cols <- colnames(.data)
  cat_cols <- cat_cols[startsWith(cat_cols, "cat_")]
  .data <- dplyr::mutate(
    .data,
    value = do.call(dplyr::coalesce, lapply(cat_cols, as.name)),
    category = z22_decode(category, feature, lang = lang),
    category = factor(category, levels = cats[[lang]]),
    .keep = "unused"
  )
  dplyr::as_tibble(.data[c("category", "value", "x", "y")])
}


df_pivot_longer <- function(.data, feature, lang) {
  is_sf <- inherits(.data, "sf")
  cats <- z22_categories(feature)

  if (is_sf) {
    geom <- sf::st_geometry(.data)
    .data <- sf::st_drop_geometry(.data)
  }

  is_cat <- startsWith(names(.data), "cat_")
  n_cats <- ncol(.data)
  other_cols <- .data[!is_cat]
  .data <- utils::stack(.data, select = is_cat)
  names(.data) <- c("value", "category")
  .data <- .data[c("category", "value")]
  .data[names(other_cols)] <- other_cols

  .data$category <- z22_decode(.data$category, feature, lang = lang)
  .data$category <- factor(.data$category, cats[[lang]])
  .data <- dplyr::as_tibble(.data)

  if (is_sf) {
    .data$geometry <- rep(geom, times = n_cats)
    .data <- sf::st_as_sf(.data)
  }

  .data
}
