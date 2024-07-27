extract_descriptors <- function(x) {
  # extract labelled metadata
  attrib <- c("Ident", "Status", "Parameter")
  meta <- x[attrib]

  # find copyright and add it to metadata
  meta <- c(Copyright = x[[length(x)]], meta)
  meta
}


add_descriptors <- function(x, attrib) {
  attributes(x) <- c(attributes(x), attrib)
  x
}


#' Descriptors
#' @description
#' Descriptors represent the metadata added to each Zensus response. They
#' include request parameters, service details, status information, and
#' copyright notices.
#'
#' @param x An object returned by a \code{z22_*} function.
#' @param type The type of descriptor to return.
#'
#' @returns A list of response metadata of a \code{z22_*} object.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # get a z22 object
#' res <- z22_statistics()
#'
#' # retrieve its descriptors
#' get_descriptors(res)
#' }
get_descriptors <- function(x,
                            type = c("params", "service", "status", "copyright")) {
  type <- match_arg(type)
  meta_names <- list(
    params = "Parameter",
    service = "Ident",
    status = "Status",
    copyright = "Copyright"
  )
  attr(x, meta_names[[type]])
}
