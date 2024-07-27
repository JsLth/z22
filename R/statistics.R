#' Statistics
#' @description
#' Returns a list of statistics according to specified parameters.
#'
#' @param selection A search string with a maximum of 15 characters. The
#' statistics catalog is searched for the selection string. The
#' \code{searchcriterion} can be used to specify which column should be
#' searched. Search strings can use the wildcard operator \code{*}.
#' @param searchcriterion Column to search for the search string in
#' \code{selection}. Must be one of \code{"code"} or \code{"content"}.
#' @param sortcriterion Column by which to sort the result.
#' Must be one of \code{"code"} or \code{"content"}.
#' @inheritParams z22_find
#'
#' @returns A dataframe containing the code, description, and cubes of
#' all queried statistics.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # return all statistics
#' z22_statistics()
#'
#' # sort by content name
#' z22_statistics(sortcriterion = "content")
#'
#' # search for all codes starting with 3000
#' z22_statistics("3000*")
#' }
z22_statistics <- function(selection = NULL,
                           searchcriterion = c("code", "content"),
                           sortcriterion = c("code", "content"),
                           pagelength = 100L) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  searchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "statistics",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


z22_statistics_to_variable <- function(name = NULL,
                                       selection = NULL,
                                       searchcriterion = c("code", "content"),
                                       sortcriterion = c("code", "content"),
                                       pagelength = 100L) {
  check_string(name, null = TRUE)
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  searchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)
  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "statistics2variable",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}
