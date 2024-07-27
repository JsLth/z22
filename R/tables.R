#' Tables
#' @description
#' Returns a list of statistics according to specified parameters.
#'
#' @param statistic Name of a statistic for which to return tables.
#' @param variable Name of a variable for which to return tables.
#' @param area If \code{type} is \code{table}, specifies the permission area
#' in which a table is stored. Can be \code{"all"}, \code{"public"}, or
#' \code{"user"}.
#' @inheritParams z22_find
#' @inheritParams z22_statistics
#'
#' @returns A dataframe containing the code, description, and cubes of
#' all queried statistics.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # return all tables
#' z22_tables()
#'
#' # sort by content name
#' z22_statistics(sortcriterion = "content")
#'
#' # search for all codes starting with 1000A-100
#' z22_tables(selection = "1000A-100*")
#' }
z22_tables <- function(statistic = NULL,
                       variable = NULL,
                       selection = NULL,
                       area = c("all", "public", "user"),
                       searchcriterion = c("code", "contents"),
                       sortcriterion = c("code", "contents"),
                       pagelength = 100L) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  area <- match_arg(area)
  searchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)

  res <- if (!is.null(statistic)) {
    params <- .make_params(
      name = statistic,
      selection = selection,
      area = area,
      pagelength = pagelength
    )
    request_zensus(
      service = "catalogue",
      method = "tables2statistic",
      params = params
    )
  } else if (!is.null(variable)) {
    params <- .make_params(
      name = variable,
      selection = selection,
      area = area,
      pagelength = pagelength
    )
    request_zensus(
      service = "catalogue",
      method = "tables2variable",
      params = params
    )
  } else {
    params <- .make_params(
      name = statistic,
      selection = selection,
      area = area,
      searchcriterion = searchcriterion,
      sortcriterion = sortcriterion,
      pagelength = pagelength
    )
    request_zensus(
      service = "catalogue",
      method = "tables",
      params = params
    )
  }

  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}
