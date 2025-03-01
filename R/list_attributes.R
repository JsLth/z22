#' List available attributes
#' @description
#' Retrieve a list of available attributes for either the 100m or 1km grid.
#'
#' @param topic A character vector containing topics to filter by. If provided,
#' only features are returned that belong to the specified topics. Ignored
#' if \code{res} is \code{"1km"}.
#' @param feature A character vector containing features to filter by. If
#' provided, only categories are returned that belong to the specified feature.
#' Ignored if \code{res} is \code{"1km"}.
#' @param decode Whether to add descriptive labels for features and categories.
#' @inheritParams z22_decode_feat
#' @inheritParams z22_get_attribute_100m
#'
#' @returns If \code{res} is \code{"100m"}, returns a tibble containing the
#' attributes topics, features, and categories. If \code{res} is \code{"1km"},
#' returns a tibble with one column containing the attribute name.
#'
#' If \code{decode} is \code{TRUE}, binds two more columns containing the
#' labels for each feature and category.
#'
#' @export
#'
#' @examples
#' # List all high-res attributes
#' z22_list_attributes()
#'
#' # List only attributes about the heating type
#' z22_list_attributes(feature = "heating_type")
#'
#' # List low-res attributes
#' z22_list_attributes(res = "1km")
#'
#' # Add additional label information to the list
#' z22_list_attributes(decode = TRUE)
z22_list_attributes <- function(topic = NULL,
                                feature = NULL,
                                res = "100m",
                                decode = FALSE,
                                lang = c("english", "german")) {
  lang <- match.arg(lang)
  idx_file <- system.file(sprintf("extdata/index_%s.txt", res), package = "z22")
  index <- readLines(idx_file)

  if (identical(res, "100m")) {
    z22_list_attributes_100m(
      index,
      topic = topic,
      feature = feature,
      decode = decode,
      lang = lang
    )
  } else {
    z22_list_attributes_1km(index, decode = decode, lang = lang)
  }
}

z22_list_attributes_100m <- function(index, topic, feature, decode, lang) {
  proto <- list(
    topic = character(),
    feature = character(),
    category = integer()
  )

  index <- utils::strcapture(
    "(^[a-z]+)(?:_(.*?))?(?:_(\\d+))?$",
    index,
    proto = proto,
    perl = TRUE
  )

  index$feature[!nzchar(index$feature)] <- NA
  index <- index[order(index$topic, index$feature, index$category),]

  if (!is.null(topic)) {
    index <- index[index$topic %in% topic, ]
  }

  if (!is.null(feature)) {
    index <- index[index$feature %in% feature, ]
  }

  if (decode) {
    index <- cbind(
      index,
      feature_label = z22_decode_feat(index$feature, lang = lang),
      category_label = z22_decode_cat(
        index$feature,
        index$category,
        lang = lang,
        parallel = TRUE
      )[[lang]]
    )
  }

  if (identical(lang, "english")) {
    index$feature <- z22_translate_feat(
      index$feature,
      type = "name",
      lang = "english"
    )
  }

  dplyr::as_tibble(index)
}


z22_list_attributes_1km <- function(index, decode, lang) {
  if (identical(lang, "english")) {
    index <- z22_translate_feat(index, type = "name", lang = "english")
  }

  label <- if (isTRUE(decode)) z22_decode_feat(index, lang = lang)

  dplyr::tibble(
    feature = index,
    feature_label = label
  )
}
