zensus_api <- function() "https://www-genesis.destatis.de/genesisWS/rest/2020/"

request_zensus <- function(service,
                           method,
                           params = list()) {
  http_method <- ifelse(getOption("z22_kvp", FALSE), "GET", "POST")

  req <- httr2::request(zensus_api())
  req <- httr2::req_url_path_append(req, service, method)

  if (identical(http_method, "GET")) {
    req <- do.call(httr2::req_url_query, c(list(req), params))
  } else {
    req <- httr2::req_headers(
      req,
      `Content-Type` = "application/x-www-form-urlencoded",
      username = params$username,
      password = params$password
    )
    params$username <- NULL
    params$password <- NULL
    req <- httr2::req_body_json(req, params, auto_unbox = TRUE)
  }

  if (getOption("z22_echo", FALSE)) {
    cat(http_method, req$url, "\n")
  }

  req$url <- utils::URLencode(req$url)
  resp <- httr2::req_perform(req)
  httr2::resp_body_json(resp)
}
