#' Get Census 2022 gridded attribute
#' @description
#' Retrieve the values and coordinates of gridded attributes from the Census
#' 2022.
#'
#' @param attribute The name of an attribute. A list of attributes can be
#' retrieved using \code{\link{z22_list_attributes}}.
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
z22_get_attribute <- function(attribute,
                              categories = NULL,
                              year = c("2011", "2022"),
                              res = c("10km", "1km", "100m"),
                              all_cells = FALSE,
                              rasterize = FALSE,
                              as_sf = FALSE) {
  res <- match.arg(res)
  year <- match.arg(year)
  year <- substr(year, 3, 4)
  gfeature <- z22_translate_feat(feature, type = "name", lang = "german")
  lang <- if (identical(gfeature, feature)) "german" else "english"
  feature <- gfeature
  #check_attribute_100m(topic, feature, category, lang)

  if (identical(year, "2011") && identical(res, "10km")) {
    cli::cli_abort(c(
      "Census 2011 data at a 10km resolution are not available",
      "i" = "You can aggregate them manually, though"
    ))
  }

  if (!is.null(categories)) {
    if (identical(year, "11") && identical(res, "1km")) {
      cli::cli_warn("No categories are defined for Census 2011 data at a 1km resolution.")
    }

    if (length(attribute) != 1 && length(attribute) != length(categories)) {
      cli::cli_abort(c(
        "`attribute` cannot be recycled to the length of `categories`.",
        "i" = paste(
          "If `categories` is provided, `attribute` must contain either a",
          "single value or as many values as there are categories."
        )
      ))
    }

    attribute <- paste0(attribute, "_", categories)
  }

  parq_file <- z22data_get(fid, "100m")
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
z22_grid <- function(res, year = 2019, rasterize = FALSE, as_sf = FALSE) {
  res <- match.arg(res, c("100km", "10km", "5km", "1km", "500m", "100m"))
  year <- match.arg(as.character(year), c("2015", "2017", "2018", "2019"))
  gid <- sprintf("grid_%s_%s", year, res)
  grid <- arrow::read_parquet(z22data_get("grids", gid))
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


z22data_get <- function(fid, dir) {
  data_dir <- getOption("z22.data_repo")

  if (!is.null(data_dir) && dir.exists(data_dir)) {
    data_dir <- file.path(data_dir, paste0("data_", res))
    if (!dir.exists(data_dir)) {
      abort_corrupt_data_dir()
    }

    parq_file <- list.files(data_dir, pattern = fid)
  } else {
    parq_file <- z22data_download(fid, dir)
  }
}


z22data_download <- function(fid,
                             dir,
                             user = "jslth",
                             repo = "z22data",
                             path = tempfile(fileext = ".parquet")) {
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
