#' Decode and translate features and categories
#' @description
#' Replace category codes with their labels.
#'
#' @param .data Output of \code{\link{z22_data}}.
#' @param feature A grid feature that is represented by \code{.data}.
#' @param lang Specifies the language of the output description. Can be
#' either \code{"english"} (default) or \code{"german"}. Note that the
#' English descriptions are only ad-hoc translations based off the German
#' originals.
#' @returns \code{.data} with category codes decoded to labels.
#'
#' @export
#'
#' @examples
#' # retrieves a the translation of cat codes directly
#' z22_decode(1, "marital_status")
#'
#' # recycles codes
#' z22_decode(c(1, 1, 1), "marital_status")
#'
#' # undefined codes are returned as NA
#' z22_decode(c(1, 2, 3), feature = "sex")
#'
#' # special case: cat_* strings
#' z22_decode("cat_2", feature = "sex")
z22_decode <- function(codes, feature, lang = c("english", "german")) {
  lang <- match.arg(lang)
  cats <- z22_categories(feature)

  if (is.character(codes) && all(startsWith(codes, "cat_"))) {
    codes <- as.integer(regex_match(codes, ".*_(.*)", i = 2))
  }

  cat_codes <- cats$code[codes]
  cats[[lang]][cat_codes]
}
