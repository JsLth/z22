#' Find an object
#' @description
#' Search for a table, statistic, or variable.
#'
#' @param term Search term.
#' @param category Category in which to search. Must be one of \code{"all"},
#' \code{"tables"}, \code{"statistics"}, or \code{"variables"}.
#' @param pagelength Number of results to return up to a maximum of 2,500.
#' Defaults to 100.
#'
#' @returns A dataframe containing the search results in long format.
#' The \code{type} column specifies the type of search result. Every result
#' includes columns \code{Code} and \code{Content}. Depending on the result
#' type, the dataframe can contain additional columns.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # search for table, statistics, and variables containing "population"
#' z22_find("population")
#'
#' # restrict the search to statistics
#' z22_find("population", category = "statistics")
#' }
z22_find <- function(term = NULL, category = NULL, pagelength = 100) {
  params <- .make_params()
  res <- request_zensus(
    service = "find",
    method = "find",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- res[c("Cubes", "Statistics", "Tables", "Timeseries", "Variables")]
  res <- bind_rows(lapply(res, rbind_list), .id = "type")
  res <- add_descriptors(res, meta)
  res
}
