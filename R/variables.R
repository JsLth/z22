#' Variables
#' @description
#' Return a list of variables according to the specified parameters.
#'
#' @param selection A search string with a maximum of 6 characters. The
#' statistics catalog is searched for the selection string. The
#' \code{searchcriterion} can be used to specify which column should be
#' searched. Search strings can use the wildcard operator \code{*}.
#' @param type Type of variable to include. This argument accepts several
#' multi-language values: \code{"all"} or \code{"alle"} includes all types of
#' variables. \code{"insgesamt"} includes variables about regional
#' totals. \code{"räumlich"} includes variables about spatial units.
#' \code{"sachlich"} or \code{"subject"} includes variables about subjects.
#' \code{"wert"} or \code{"value"} includes variables about specific values.
#' \code{"classifying"} or \code{"klassifizierend"} includes variables of
#' types subject, regional, and regional total. \code{"zeitidentifizierend"}
#' includes variables about temporal units. \code{"classifying"} or
#' \code{"klassifizierend"} includes classifying variable types "subject",
#' "regional", and "regional total".
#' @inheritParams z22_find
#'
#' @returns \code{z22_variables} and \code{z22_variables_from_statistic} return
#' a dataframe containing the code, content, type, and number of
#' values of a variable.
#'
#' \code{z22_variable} returns a list of metadata with class \code{z22_details}
#' on a specific variable.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # return the first 100 variables
#' z22_variables()
#'
#' # search for age-related code
#' z22_variables("ALT*")
#'
#' # search for age-related descriptions
#' z22_variables("Age*", searchcriterion = "content")
#'
#' # return only space-related variables
#' z22_variables(type = "räumlich")
#'
#' # return all variables from a specific statistic
#' z22_variables_from_statistic("1000A")
#'
#' # return metadata on a variable
#' z22_variable("GEBEN1")
#' }
z22_variables <- function(selection = NULL,
                          searchcriterion = c("code", "content"),
                          sortcriterion = c("code", "content"),
                          type = "all",
                          pagelength = 100L) {
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  searchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)
  type <- match_arg(type, choices = vartypes)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "variables",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


#' @rdname z22_variables
#' @export
#' @param name For \code{z22_variables_from_statistic}, a code of a statistic
#' whose variables to return. For \code{z22_variable}, the code of a variable
#' for which to return metadata.
z22_variables_from_statistic <- function(name,
                                         selection = NULL,
                                         searchcriterion = c("code", "content"),
                                         sortcriterion = c("code", "content"),
                                         type = "all",
                                         pagelength = 100L) {
  check_string(name)
  check_string(selection, null = TRUE)
  check_integerish(pagelength)
  searchcriterion <- match_arg(searchcriterion)
  sortcriterion <- match_arg(sortcriterion)
  type <- match_arg(type, choices = vartypes)

  params <- .make_params()
  res <- request_zensus(
    service = "catalogue",
    method = "variables2statistic",
    params = params
  )
  meta <- extract_descriptors(res)
  res <- as_df(rbind_list(res$List))
  res <- add_descriptors(res, meta)
  res
}


vartypes <- c(
  "all", "alle",
  "classifying", "klassifizierend",
  "subject", "sachlich",
  "insgesamt",
  "räumlich",
  "value", "wert",
  "zeitidentifizierend"
)
