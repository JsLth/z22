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
#' @param parallel If \code{TRUE}, decodes categories in parallel, similar
#' to how \code{pmax} and \code{pmin} work. If \code{TRUE}, \code{features}
#' and \code{codes} must always have the same length and a dataframe with the
#' same number of rows is returned. If \code{FALSE}, \code{features} can have
#' a different length than \code{codes} and the output can be longer, depending
#' on how many more codes there are than features. Defaults to \code{FALSE}.
#' See examples.
#' @returns \code{z22_decode_feat} returns a character vector with the same
#' length as \code{features} containing the English or German descriptions
#' of the features or categories.
#'
#' \code{z22_decode_cat} always returns a tibble with three columns
#' \code{feature}, \code{code}, and \code{label} where the label contains the
#' decoded description. If \code{parallel = TRUE}, the tibble contains the
#' same number of rows as the length of the input.
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
#'
#' # The `lang` argument only changes the output. The input can be any language
#' z22_decode_cat("foreigner_share", lang = "german")
#'
#' # The parallel argument allows you to extract a single category label for
#' # each combination of feature and category code
#' z22_decode_cat(c("build_heating", "build_heating"), c(1,2))
#' z22_decode_cat(c("build_heating", "build_heating"), c(1,2), parallel = TRUE)
z22_decode_feat <- function(features, lang = c("english", "german")) {
  lang <- match.arg(lang)
  all_feats <- get("features", envir = asNamespace("z22"))

  sel_feats <- all_feats[
    all_feats$feature %in% features |
      all_feats$feature_en %in% features, ,
    drop = TRUE
  ]

  sel_idx <- dplyr::coalesce(
    match(features, sel_feats$feature),
    match(features, sel_feats$feature_en)
  )
  sel_feats[[lang]][sel_idx]
}


#' @rdname z22_decode_feat
#' @export
z22_decode_cat <- function(features,
                           codes = NULL,
                           lang = c("english", "german"),
                           parallel = FALSE) {
  if (parallel && length(features) != length(codes)) {
    cli::cli_abort(c(
      "If `parallel = TRUE`, the same number of features and codes must be provided.",
      "i" = "There are {length(features)} features and {length(codes)} codes."
    ))
  }

  lang <- match.arg(lang)
  all_cats <- get("categories", envir = asNamespace("z22"))
  all_cats$feature_en <- z22_translate_feat(
    all_cats$feature,
    type = "name",
    lang = "english"
  )

  all_cats <- all_cats[
    all_cats$feature %in% features |
      all_cats$feature_en %in% features, ]

  dec <- lapply(seq_along(features), function(i) {
    fi <- features[i]
    ci <- if (parallel) codes[i] else codes
    cats <- all_cats[all_cats$feature %in% fi | all_cats$feature_en %in% fi, ]
    is_code <- cats$code %in% ci
    if (is.null(codes)) {
      is_code <- !is_code
    }

    if (length(is_code)) {
      cats[is_code, c("code", lang), drop = TRUE]
    } else {
      na_tbl(c("code", lang))
    }
  })
  features[is.na(features)] <- "NA"
  names(dec) <- features
  dec <- dplyr::bind_rows(dec, .id = "feature")
  dec$feature[dec$feature %in% "NA"] <- NA
  names(dec[lang]) <- "label"
  dec
}


#' @rdname z22_decode_feat
#' @export
z22_translate_feat <- function(features,
                               type = c("desc", "name"),
                               lang = c("english", "german")) {
  type <- match.arg(type)
  lang <- match.arg(lang)
  all_feats <- get("features", envir = asNamespace("z22"))
  all_feats <- dplyr::bind_rows(all_feats, na_tbl(names(all_feats)))

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
        "The following {length(na_cats)} categories{?s}",
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
