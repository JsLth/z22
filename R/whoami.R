#' Zensus2022 available?
#' @description
#' Checks if the Zensus2022 database server can be reached or not.
#'
#' @export
#'
#' @examples
#' z22_available()
z22_available <- function() {
  request_zensus(service = "helloworld", method = "whoami")[["User-Agent"]]
}
