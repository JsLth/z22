#' Zensus catalogue
#' @description
#' Retrieve census contents of statistics, variables, tables, values,
#' and results.
#'
#' @param object The type of object for which to return lists.
#' @param ... Further arguments passed to \code{\link{z22_statistics}},
#' \code{\link{z22_variables}}, \code{\link{z22_tables}},
#' \code{\link{z22_values}}, or \code{\link{z22_results}}.
#' @inheritParams z22_find
#' @inheritParams z22_statistics
#'
#' @returns A dataframe containing information on the code, content, and
#' number of variables.
#'
#' @export
z22_catalogue <- function(object,
                          selection = NULL,
                          ...,
                          pagelength = 100L) {
  check_string(object)
  fun <- match.fun(paste0("z22_", object))
  fun(selection = selection, pagelength = pagelength, ...)
}


z22_jobs <- function(selection = NULL,
                     searchcriterion = NULL,
                     sortcriterion = NULL,
                     pagelength = 100) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  searchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "jobs",
    params = params
  )
  meta <- extract_descriptors(res)
  res
}


z22_quality_signs <- function() {
  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "qualitysigns",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


z22_modified_data <- function(selection = NULL,
                              type = c("all", "tables", "statistics"),
                              date = NULL) {
  check_string(selection, null = TRUE)
  check_date(date, null = TRUE)
  type <- match_arg(type)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "modifieddata",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


z22_terms <- function(selection = NULL, pagelength = 100L) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "terms",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


z22_results <- function(selection = NULL,
                        area = c("all", "public", "user"),
                        pagelength = 100L) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  area <- match_arg(area)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "results",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


z22_values <- function(selection = NULL,
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
    method = "values",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}
