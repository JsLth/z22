#' Metadata
#' @description
#' Returns metadata on variables, values, tables, or statistics.
#'
#' @param name Name of the variable, value, table, or statistic for which to
#' retrieve metadata.
#' @param type Whether \code{name} refers to a variable, value, table, or
#' statistic.
#' @inheritParams z22_tables
#'
#' @returns An object of class \code{z22_metadata}, which is a list of relevant
#' information about an object.
#'
#' @export
#'
z22_metadata <- function(name, type, area = c("all", "public", "user")) {
  types <- c("variable", "value", "table", "statistic")
  check_string(name)
  type <- match_arg(type, choices = types)
  area <- match_arg(area)

  params <- .make_params(name = name)
  res <- request_zensus(
    service = "metadata",
    method = type,
    params = params
  )
  meta <- extract_descriptors(res)
  res <- res$Object
  res <- add_descriptors(res, meta)
  class(res) <- "z22_metadata"
  res
}
