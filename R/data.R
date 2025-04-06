#' Get Census 2022 grid dataset
#' @description
#' Retrieve the values and coordinates of gridded attributes from the Census
#' 2022.
#'
#' An attribute is a thematic chunk divided by three aspects:
#'
#' \itemize{
#'  \item{The general \strong{topic} of the attribute, e.g. demography or
#'  families (\code{topic})}
#'  \item{A single spatial characteristic or \strong{feature}, e.g. age or
#'  household size (\code{feature})}
#'  \item{The levels or \strong{categories} of each feature, e.g. single age
#'  groups (\code{category})}
#' }
#'
#' @param topic,feature,category The topic, feature and category of the
#' request attribute. A list of available combinations can be retrieved
#' using \code{\link{z22_list_attributes}}. With the exception of
#' \code{topic = "population"} (where only the topic can be specified), all
#' arguments must be provided.
#' @param res Resolution of the grid dataset. Can be \code{"100m"}
#' or \code{"1km"}.
#' @param all_cells If \code{TRUE}, joins the retrieved attribute with the
#' complete grid from \code{\link{z22_grid}}. Otherwise, the attribute grid
#' will contain only those grid cells with one or more recorded units. Defaults
#' to \code{FALSE}, because loading the grid and joining with it is
#' computationally expensive.
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
#' @returns A tibble, \code{\link[terra:rast]{SpatRaster}} or
#' \code{\link[sf::st_as_sf]{sf}} tibble depending on the \code{rasterize}
#' and \code{as_sf} arguments.
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
#' pop <- z22_get_attribute("population", all_cells = TRUE, rasterize = TRUE)
#' terra::plot(pop)
#'
#' # Get data about buildings using district heating
#' z22_get_attribute("buildings", "HEIZTYP", 1)}
z22_data <- function(feature,
                     category = NULL,
                     all_cells = FALSE,
                     rasterize = FALSE,
                     as_sf = FALSE,
                     update_cache = FALSE) {
  gfeature <- z22_translate_feat(feature, type = "name", lang = "german")
  lang <- if (identical(gfeature, feature)) "german" else "english"
  feature <- gfeature
  check_attribute_100m(topic, feature, category, lang)
  fid <- build_fid(topic, feature, category, "100m")
  parq_file <- z22data_get(fid, "100m", overwrite = update_cache)
  att <- arrow::read_parquet(parq_file)

  if (isTRUE(all_cells)) {
    grid <- z22_grid(res)
    att <- dplyr::left_join(grid, att, by = c("x", "y"))
    att$value[is.na(att$value)] <- 0
  }

  # Exchange INSPIRE coordinates with geographic centroids
  att$x <- att$x + 50
  att$y <- att$y + 50

  as_spatial_maybe(att, rasterize = rasterize, as_sf = as_sf)
}


#' Get INSPIRE grid
#' @description
#' Retrieve the entire INSPIRE grid.
#'
#' Unlike the attribute grids retrieved from \code{\link{z22_data}},
#' the INSPIRE grid encompasses the entire area of Germany. You can thus use
#' it to join with the incomplete attribute grids from \code{z22_data}
#' to create a complete dataset.
#'
#' @param res Resolution of the grid. Can be \code{"100m"}, \code{"250m"},
#' \code{"1km"}, \code{"5km"} or \code{"10km"}.
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
z22_grid <- function(res, year = 2019, rasterize = FALSE, as_sf = FALSE, cache = TRUE) {
  years <- c(2015, 2017, 2018, 2019)
  if (!year %in% years) {
    cli::cli_abort(c(
      "No grid available for year {year}.",
      "i" = "INSPIRE grids are available for {years}"
    ))
  }

  reses <- c("100m", "250m", "1km", "5km", "10km")
  if (!res %in% reses) {
    cli::cli_abort(c(
      "No grid available at a resolution of {res}.",
      "i" = "INSPIRE grids are available at the following resolutions: {reses}"
    ))
  }

  fid <- sprintf("grid_%s_%s", year, res)
  path <- z22data_get("grids", fid, overwrite = !cache)
  grid <- arrow::read_parquet(path)
  if (!cache) unlink(path)
  as_spatial_maybe(grid, rasterize = rasterize, as_sf = as_sf)
}


as_spatial_maybe <- function(x, rasterize, as_sf) {
  if (isTRUE(rasterize)) {
    check_loadable("terra", "rasterize the attribute grid")
    terra::rast(x, type = "xyz", crs = "EPSG:3035")
  } else if (isTRUE(as_sf)) {
    check_loadable("sf", "convert the attribute grid to an sf object")
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
      abort_corrupt_data_dir()
    }

    parq_file <- list.files(data_dir, pattern = fid, full.names = TRUE)
  } else {
    temp_path <- file.path(tempdir(), paste0(fid, ".parquet"))
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


check_attribute_100m <- function(topic, feature, category, lang) {
  Map(topic, feature, category, f = function(t, f, c) {
    atts <- z22_list_attributes(t, f, lang = lang)
    if (!c %in% atts$category) {
      cli::cli_abort(c(
        paste(
          "The combination of topic = {.val {topic}}, feature = {.val",
          "{feature}} and category = {.val {category}} does not exist."
        ),
        "i" = "Check out `z22_list_attributes()`."
      ))
    }
  })
}


abort_corrupt_data_dir <- function() {
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
