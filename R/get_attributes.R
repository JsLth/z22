z22_get_attributes <- function(category, feature, dataset, res = "100m", rasterize = TRUE) {
  fid <- paste(category, feature, dataset, sep = "_")
  data_dir <- getOption("z22.data_repo")

  if (!is.null(data_dir) && dir.exists(data_dir)) {
    data_dir <- file.path(data_dir, paste0("data_", res))
    if (!dir.exists(data_dir)) {
      abort_corrupt_data_dir()
    }

    parq_file <- list.files(data_dir, pattern = fid)
    att <- arrow::read_parquet(parq_file)
  } else {

  }
}


#https://api.github.com/repos/[USER]/[REPO]/git/trees/[BRANCH]?recursive=1
#https://github.com/JsLth/z22data/tree/main/data_100m
peek_repo <- function(user = "jslth", repo = "z22data", branch = "main")


abort_corrupt_data_dir <- function() {
  cli::cli_abort(c(
    paste(
      "Directory specified in `getOption(\"z22.data_repo\")` is",
      "not a valid z22 data repository."
    ),
    "i" = paste(
      "Download the data from {.url https://github.com/jslth/z22data}",
      "or set `options(z22.data_repo = NULL)`."
    )
  ))
}
