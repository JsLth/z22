#' Get Census 2022 gridded attribute
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
#'
#' @returns A tibble, \code{\link[terra:rast]{SpatRaster}} or
#' \code{\link[sf::st_as_sf]{sf}} tibble depending on the \code{rasterize}
#' and \code{as_sf} arguments.
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
z22_get_attribute <- function(topic,
                              feature,
                              category,
                              res = c("100m", "1km"),
                              all_cells = FALSE,
                              rasterize = FALSE,
                              as_sf = FALSE) {
  fid <- build_fid(topic, feature, category)
  parq_file <- z22data_get(fid, res)
  att <- arrow::read_parquet(parq_file)

  if (isTRUE(all_cells)) {
    grid <- z22_grid(res)
    att <- dplyr::left_join(grid, att, by = c("x", "y"))
    att$value[is.na(att$value)] <- 0
  }

  as_spatial_maybe(att, rasterize = rasterize, as_sf = as_sf)
}


#' Get INSPIRE grid
#' @description
#' Retrieve the entire INSPIRE grid.
#'
#' Unlike the attribute grids retrieved from \code{\link{z22_get_attribute}},
#' the INSPIRE grid encompasses the entire area of Germany. You can thus use
#' it to join with the incomplete attribute grids from \code{z22_get_attribute}
#' to create a complete dataset.
#'
#' @inherit z22_get_attribute
#'
#' @export
#'
#' @examples
#' \donttest{# Get high-res grid
#' z22_grid()
#'
#' # Get low-res grid as raster
#' z22_grid("1km", rasterize = TRUE)}
z22_grid <- function(res, rasterize = FALSE, as_sf = FALSE) {
  grid <- arrow::read_parquet(z22data_get("_grid", res))
  as_spatial_maybe(grid, rasterize = rasterize, as_sf = as_sf)
}


as_spatial_maybe <- function(x, rasterize, as_sf) {
  if (isTRUE(rasterize)) {
    check_loadable("terra", "rasterize the attribute grid")
    terra::rast(x[c("x", "y", "value")], type = "xyz", crs = "EPSG:3035")
  } else if (isTRUE(as_sf)) {
    check_loadable("sf", "convert the attribute grid to an sf object")
    sf::st_as_sf(x, coords = c("x", "y"), crs = 3035)
  } else {
    x
  }
}


build_fid <- function(dataset, feature, category) {
  paste0(
    dataset,
    if (!missing(feature) && !is.null(feature)) paste0("_", feature),
    if (!missing(category) && !is.null(category)) paste0("_", category)
  )
}


z22data_get <- function(fid, res) {
  data_dir <- getOption("z22.data_repo")

  if (!is.null(data_dir) && dir.exists(data_dir)) {
    data_dir <- file.path(data_dir, paste0("data_", res))
    if (!dir.exists(data_dir)) {
      abort_corrupt_data_dir()
    }

    parq_file <- list.files(data_dir, pattern = fid)
  } else {
    parq_file <- z22data_download(fid, res)
  }
}


z22data_download <- function(fid,
                             res,
                             user = "jslth",
                             repo = "z22data",
                             path = tempfile(fileext = ".parquet")) {
  req <- httr2::request("https://github.com/")
  req <- httr2::req_url_path(
    req, "jslth", "z22data", "raw", "refs", "heads",
    "main", paste0("data_", res), paste0(fid, ".parquet")
  )
  unclass(httr2::req_perform(req, path = path)$body)
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
