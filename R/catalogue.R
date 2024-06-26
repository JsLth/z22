z22_jobs <- function(selection = NULL,
                     searchcriterion = NULL,
                     sortcriterion = NULL,
                     pagelength = 100) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  serchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)

  params <- .make_params()
  request_zensus(
    service = "catalogue",
    method = "jobs",
    params = params
  )
}


z22_qualitysigns <- function() {
  params <- .make_params()
  request_zensus(
    service = "catalogue",
    method = "qualitysigns",
    params = params
  )
}


z22_statistics <- function(selection = NULL,
                           searchcriterion = NULL,
                           sortcriterion = NULL,
                           pagelength = NULL) {
  params <- .make_params()
  request_zensus(
    service = "catalogue",
    method = "statistics",
    params = params
  )
}
