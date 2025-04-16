#' Get Census 2022 grid dataset
#' @description
#' Retrieve the values and coordinates of gridded features from the censuses
#' 2011 and 2022.
#'
#' When we are talking about a
#'
#' \itemize{
#'  \item{\strong{feature}, we talk about an indicator aggregated to grid cells,
#'  e.g., age or the number of dwellings.}
#'  \item{\strong{category}, we talk about the discrete classifications of
#'  features, e.g., ages 10 to 19, 20 to 20, 30 to 39, etc.}
#'  \item{Both feature and category have to be provided to uniquely identify
#'  a \strong{dataset}.}
#' }
#'
#' @param feature A grid feature. See \code{\link{z22_features}} for a list
#' of available features. You can pass both English names and legacy names
#' (i.e., variable names from the 2011 census).
#' @param categories One or multiple feature categories. See
#' \code{\link{z22_categories}} for a list of available categories. If
#' \code{NULL}, retrieves all categories for a given feature. Generally,
#' the more categories are selected, the longer the download.
#' @param year Census year. Currently, only 2011 and 2022 are available.
#' Defaults to 2022.
#' @param res Resolution of the grid dataset. Can be \code{"100m"},
#' \code{"1km"}, or \code{"10km"}. If \code{year} is 2011, \code{"10km"} is
#' not available and some features are only available at certain resolutions.
#' @param all_cells If \code{TRUE}, joins the retrieved attribute with the
#' complete grid from \code{\link{z22_grid}}. Otherwise, the attribute grid
#' will contain only those grid cells with one or more recorded units. Defaults
#' to \code{FALSE}, because loading the grid and joining with it is
#' computationally expensive.
#' @param normalize If \code{TRUE} and \code{feature} is a counted feature,
#' computes shares by dividing the counts by the total number of units in the
#' grid cell. The type of unit depends on the theme of the feature, e.g., if
#' the feature is in theme "Buildings", the feature counts are divided by the
#' total number of buildings. Note that this operation requires an additional
#' download (the total number of units). Also note that sometimes (possibly due
#' to the key-cell method), shares of over 1 are computed. Defaults to
#' \code{FALSE}.
#' @param rasterize If \code{TRUE} and the \code{terra} package is installed,
#' converts the attribute coordinates to a \code{\link[terra:rast]{SpatRaster}}.
#' @param as_sf If \code{TRUE} and the \code{sf} package is installed,
#' converts the attribute coordinates to an \code{sf} tibble.
#' @param update_cache By default, both functions cache attribute files for
#' the remainder of the R session. They are downloaded to a temporary directory
#' and - if the file to download already exists - are recovered from the cache.
#' In other words, when rerunning the same request multiple times, the
#' subsequent calls should be much faster. If \code{TRUE}, disables caching
#' for this call and overwrites the currently cached attribute file (if any)
#' with a fresh one. Defaults to \code{FALSE}, i.e. always cache.
#'
#' @returns A tibble, \code{\link[terra:sds]{SpatRasterDataset}} or
#' \code{\link[sf:st_as_sf]{sf}} tibble depending on the \code{rasterize}
#' and \code{as_sf} arguments.
#'
#' If a tibble is returned each category in \code{categories} is stored in
#' a column. If a \code{SpatRasterDataset} is returned, each category is a
#' named layer.
#'
#' @details
#' Half of the grids cell width is added to each coordinate in the
#' dataset internally. According to the INSPIRE guidelines, coordinates
#' always represent the South-west of the grid cells. Centroids represent
#' the geographic location of grid cells better which is why they are used.
#'
#' @export
#'
#' @examples
#' \donttest{# Get gridded population
#' pop <- z22_data("population", res = "10km", rasterize = TRUE)
#' terra::plot(pop$cat_0)
#'
#' # Get data about the number of people born in a EU27 country
#' z22_data("birth_country", categories = 21, res = "1km")}
z22_data <- function(feature,
                     categories = NULL,
                     year = 2022,
                     res = "1km",
                     all_cells = FALSE,
                     normalize = FALSE,
                     rasterize = FALSE,
                     as_sf = FALSE,
                     update_cache = FALSE) {
  check_year(year)
  check_resolution(res, year)
  feature <- get_feature_any(feature)
  check_feature(feature, year, res)
  categories <- categories %||% z22_categories(feature)$code
  check_category(categories, feature)
  check_normalize(normalize, feature)

  # another country group was added in 2022 which is not available in 2011
  if (year == 2011 && feature %in% c("birth_country", "citizenship_group")) {
    categories <- setdiff(categories, 20)
  }

  year <- substr(year, 3, 4)
  dir <- sprintf("z%s_data_%s", year, res)
  out <- lapply(categories, function(cat) {
    fid <- sprintf("%s_%s", feature, cat)
    parq_file <- z22data_get(dir, fid, overwrite = update_cache)
    out_feat <- arrow::read_parquet(parq_file)
    rename(out_feat, value = sprintf("cat_%s", cat))
  })
  out <- Reduce(out, f = function(x, y) {
    y <- y[!colnames(y) %in% "quality"]
    dplyr::left_join(x, y, by = c("x", "y"))
  })

  if (normalize) {
    # To normalize, the respective totals dataframe is downloaded and
    # used to divide the counts of the feature grid
    theme <- tolower(features[features$name %in% feature, ]$theme)
    fid <- sprintf("%s_%s", theme, 0)
    parq_file <- z22data_get(dir, fid, overwrite = update_cache)
    total <- arrow::read_parquet(parq_file)
    out <- dplyr::left_join(out, total, by = c("x", "y"))
    out <- dplyr::mutate(out, dplyr::across(
      dplyr::starts_with("cat_"),
      .fns = ~.x / value
    ), .keep = "unused")
  }

  if (isTRUE(all_cells)) {
    grid <- z22_grid(res)
    out <- dplyr::left_join(grid, out, by = c("x", "y"))

    # counts are always 0 if values are missing
    # for shares or averages, it's a bit more complicated so they stay NA
    type <- features[features$name %in% feature, ]$type
    if (type %in% "count") {
      out <- dplyr::mutate(out, dplyr::across(
        dplyr::starts_with("cat_"),
        .fns = ~replace(.x, is.na(.x), 0)
      ))
    }
  }

  # Exchange INSPIRE coordinates with geographic centroids
  out$x <- out$x + 50
  out$y <- out$y + 50

  out <- move_to_front(out, is_cat_col(out))
  as_spatial_maybe(out, rasterize = rasterize, as_sf = as_sf)
}


#' Get INSPIRE grid
#' @description
#' Retrieve the entire INSPIRE grid.
#'
#' Unlike the feature grids retrieved from \code{\link{z22_data}},
#' the INSPIRE grid encompasses the entire area of Germany. You can thus use
#' it to join with the incomplete feature grids from \code{z22_data}
#' to create a complete dataset.
#'
#' @param res Resolution of the grid. Can be \code{"100m"}, \code{"250m"},
#' \code{"1km"}, \code{"5km"}, \code{"10km"}, or \code{"100km"}.
#' @param year Version of the grid. Can be 2015, 2017, 2018 and 2019. Defaults
#' to the latest version.
#' @inherit z22_data
#'
#' @details
#' Note the uncompressed object sizes of the output (2019 version):
#'
#' \itemize{
#'  \item{100 m: 38 million cells, 291 MB}
#'  \item{250 m: 6 million cells, 47 MB}
#'  \item{1 km: 384 thousand cells, 3 MB}
#'  \item{5 km: 16 thousand cells, 0.12 MB}
#'  \item{10 km: 4 thousand cells, 0.03 MB}
#' }
#'
#' @export
#'
#' @examples
#' \donttest{# Get high-res grid as tibble
#' z22_grid("100m")
#'
#' # Get low-res grid as raster
#' z22_grid("1km", rasterize = TRUE)}
z22_grid <- function(res, year = 2019, rasterize = FALSE, as_sf = FALSE, update_cache = FALSE) {
  years <- c(2015, 2017, 2018, 2019)
  if (!year %in% years) {
    cli::cli_abort(c(
      "No grid available for year {year}.",
      "i" = "INSPIRE grids are available for {years}"
    ))
  }

  reses <- c("100m", "250m", "1km", "5km", "10km", "100km")
  if (!res %in% reses) {
    cli::cli_abort(c(
      "No grid available at a resolution of {res}.",
      "i" = "INSPIRE grids are available at the following resolutions: {reses}"
    ))
  }

  fid <- sprintf("grid_%s_%s", year, res)
  path <- z22data_get("grids", fid, overwrite = update_cache)
  grid <- arrow::read_parquet(path)
  as_spatial_maybe(grid, rasterize = rasterize, as_sf = as_sf)
}


as_spatial_maybe <- function(x, rasterize, as_sf) {
  if (isTRUE(rasterize)) {
    check_loadable("terra", "rasterize the grid")
    cnames <- names(x)
    cnames <- cnames[startsWith(cnames, "cat_") | cnames %in% "quality"]
    rasters <- lapply(cnames, function(cat) {
      terra::rast(x[c("x", "y", cat)], type = "xyz", crs = "EPSG:3035")
    })
    rasters <- terra::sds(rasters)
    names(rasters) <- cnames
    rasters
  } else if (isTRUE(as_sf)) {
    check_loadable("sf", "convert the grid to an sf object")
    sf::st_as_sf(x, coords = c("x", "y"), crs = 3035)
  } else {
    x
  }
}


z22data_get <- function(dir, fid, overwrite) {
  data_dir <- getOption("z22.data_repo")

  if (!is.null(data_dir) && dir.exists(data_dir)) {
    data_dir <- file.path(data_dir, dir)
    if (!dir.exists(data_dir)) {
      cli::cli_abort(c(
        paste(
          "Directory specified in `getOption(\"z22.data_repo\")` is",
          "not a valid z22 data repository."
        ),
        "i" = paste(
          "Download the data from {.url https://github.com/jslth/z22data}",
          "or set `options(z22.data_repo = NULL)`."
        )
      ))
    }

    parq_file <- list.files(data_dir, pattern = fid, full.names = TRUE)
  } else {
    temp_path <- file.path(tempdir(), paste0(dir, fid, ".parquet"))
    parq_file <- z22data_download(
      dir,
      fid,
      path = temp_path,
      overwrite = overwrite
    )
  }
}


z22data_download <- function(dir,
                             fid,
                             user = "jslth",
                             repo = "z22data",
                             path = tempfile(fileext = ".parquet"),
                             overwrite = FALSE) {
  if (file.exists(path) && !overwrite) {
    return(path)
  }

  req <- httr2::request("https://github.com/")
  req <- httr2::req_url_path(
    req, "jslth", "z22data", "raw", "refs", "heads",
    "main", dir, paste0(fid, ".parquet")
  )
  if (getOption("z22.debug", FALSE)) {
    cli::cli_inform("GET {req$url}")
  }
  unclass(httr2::req_perform(req, path = path)$body)
}


is_cat_col <- function(.data) {
  names <- names(.data)
  startsWith(names, "cat_")
}
