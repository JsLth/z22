z22_get_data <- function(name,
                         area = c("all", "public", "user"),
                         compress = FALSE,
                         transpose = FALSE,
                         contents = NULL,
                         startyear = NULL,
                         endyear = NULL,
                         timeslices = NULL,
                         regionalvariable = NULL,
                         jobs = TRUE,
                         file = NULL) {
  area <- match_arg(area)
  params <- .make_params()

  if (!is.null(file)) {
    res <- request_zensus(
      service = "data",
      method = "tablefile",
      params = params
    )
    if (!grepl("\\.zip$", file)) {
      file <- paste0(file, ".zip")
    }
    writeBin(res, con = file)
    res <- normalizePath(file, "/")
  } else {
    res <- request_zensus(
      service = "data",
      method = "table",
      params = params
    )
    meta <- extract_descriptors(res)
    res <- utils::read.csv2(text = res$Object$Content, skip = 1, header = FALSE)
    res <- add_descriptors(res, meta)
  }

  res
}
