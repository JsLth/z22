#' Decode and translate features and categories
#' @description
#' Helper functions to get the English or German descriptions associated with
#' a feature name or category code.
#'
#' \itemize{
#'  \item{The \code{z22_decode_*} functions help to retrieve human-readable
#'  descriptions from abbreviated feature names}
#'  \item{The \code{z22_translate_*} functions help to translate feature names
#'  or descriptions from German to English or vice versa}
#' }
#'
#' @param features A character vector containing English or German feature
#' names.
#' @param codes A numeric vector containing category codes. If \code{NULL},
#' returns all category descriptions within the feature specified in the
#' \code{feature} argument.
#' @param lang Specifies the language of the output description. Can be
#' either \code{"english"} (default) or \code{"german"}. Note that the
#' English descriptions are only ad-hoc translations based off the German
#' originals.
#' @returns A character vector containing the English or German descriptions
#' of the features or categories.
#'
#' \code{z22_decode_cat} always returns a named list where each element is
#' named by its feature and contains the features matched category
#' descriptions. For consistency, this is also the case if \code{features}
#' only contains a single feature name.
#'
#' @export
#'
#' @examples
#' # Get english description of feature names
#' z22_decode_feat(c("ALTER_KURZ", "ALTER_10JG"))
#'
#' # You can use both german and english feature names.
#' # English feature names are not official but might be better
#' # for reproducibility.
#' z22_decode_feat(c("age_short", "age_long"))
#'
#' # Get all categories for specific features
#' z22_decode_cat(c("build_size", "build_heating"))
#'
#' # Translate feature names
#' z22_translate_feat(
#'   c("build_size", "build_heating"),
#'   lang = "german",
#'   type = "name"
#' )
#'
#' # Translate category labels
#' z22_translate_cat("Eingetr. Lebenspartnerschaft")
z22_decode_feat <- function(features, lang = c("english", "german")) {
  lang <- match.arg(lang)
  all_feats <- get("features", envir = asNamespace("z22"))
  all_feats[
    all_feats$feature %in% features |
      all_feats$feature_en %in% features,
    lang,
    drop = TRUE
  ]
}


#' @rdname z22_decode_feat
#' @export
z22_decode_cat <- function(features,
                           codes = NULL,
                           lang = c("english", "german")) {
  lang <- match.arg(lang)
  all_cats <- get("categories", envir = asNamespace("z22"))
  all_cats$feature <- z22_translate_feat(
    all_cats$feature,
    type = "name",
    lang = "english"
  )
  all_cats <- all_cats[all_cats$feature %in% features, ]

  if (is.null(codes)) {
    lapply(split(all_cats, all_cats$feature), "[[", lang)
  } else {
    dec <- lapply(features, function(x) {
      cats <- all_cats[all_cats$feature %in% x, ]
      cats[cats$code %in% codes, lang, drop = TRUE]
    })
    names(dec) <- features
    dec[!duplicated(dec)]
  }
}


#' @rdname z22_decode_feat
#' @export
z22_translate_feat <- function(features,
                               type = c("desc", "name"),
                               lang = c("english", "german")) {
  type <- match.arg(type)
  lang <- match.arg(lang)
  all_feats <- get("features", envir = asNamespace("z22"))

  cols <- if (identical(type, "name")) {
    list("feature", "feature_en")
  } else {
    list("german", "english")
  }

  if (identical(lang, "english")) {
    cols <- rev(cols)
  }

  names(cols) <- c("trg", "src")
  trg_idx <- match(features, all_feats[[cols$src]])

  if (anyNA(trg_idx)) {
    na_feats <- features[is.na(trg_idx)]
    type_fmt <- switch(type, desc = "description", type)
    cli::cli_abort(c(
      paste(
        "The following {length(na_feats)} {type_fmt}{cli::qty(na_feats)}{?s}",
        "could not be translated to {lang}: {.val {na_feats}}"
      ),
      "i" = paste(
        "Make sure they exist and you are trying",
        "to translate to the right language."
      )
    ))
  }
  all_feats[[cols$trg]][trg_idx]
}


#' @rdname z22_decode_feat
#' @export
z22_translate_cat <- function(categories, lang = c("english", "german")) {
  lang <- match.arg(lang)
  all_cats <- get("categories", envir = asNamespace("z22"))
  cols <- list("german", "english")

  if (identical(lang, "english")) {
    cols <- rev(cols)
  }

  names(cols) <- c("trg", "src")
  trg_idx <- match(categories, all_cats[[cols$src]])

  if (anyNA(trg_idx)) {
    na_cats <- categories[is.na(trg_idx)]
    cli::cli_abort(c(
      paste(
        "The following {length(na_feats)} categories{?s}",
        "could not be translated to {lang}: {.val {na_cats}}"
      ),
      "i" = paste(
        "Make sure they exist and you are trying",
        "to translate to the right language."
      )
    ))
  }

  all_cats[[cols$trg]][trg_idx]
}
