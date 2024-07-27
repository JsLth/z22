zensus_api <- function() "https://www-genesis.destatis.de/genesisWS/rest/2020/"
zensus_api2 <- function() "https://ergebnisse2011.zensus2022.de/api/rest/2020/"

request_zensus <- function(service,
                           method,
                           params = list()) {
  http_method <- ifelse(getOption("z22_kvp", TRUE), "GET", "POST")

  req <- httr2::request(zensus_api2())
  req <- httr2::req_url_path_append(req, service, method)

  if (identical(http_method, "GET")) {
    req <- do.call(httr2::req_url_query, c(list(req), params))
  } else {
    #req <- do.call(httr2::req_body_form, c(list(req), params))
    req <- httr2::req_body_json(req, params, auto_unbox = TRUE)
  }

  if (getOption("z22_echo", FALSE)) {
    message(paste(http_method, req$url, "\n"))
  }

  req <- httr2::req_error(req, is_error = function(resp) {
    if (is_content_type(resp, "json")) {
      content <- httr2::resp_body_json(resp)
      return(has_failed(content))
    } else if (is_content_type(resp, "zip")) {
      return(FALSE)
    }
    TRUE
  })

  resp <- httr2::req_perform(req)

  if (is_content_type(resp, "json")) {
    content <- httr2::resp_body_json(resp)
    handle_conditions(content)
  } else {
    content <- httr2::resp_body_raw(resp)
  }

  content
}


is_content_type <- function(resp, type) {
  content_type <- resp$headers$`Content-Type`
  isTRUE(grepl(sprintf("application/%s", type), content_type, fixed = TRUE))
}


has_failed <- function(resp) {
  !identical(resp$Code %||% 0L, 0L)
}


has_status <- function(resp) {
  status <- resp$Status
  if (is.character(status)) {
    return(FALSE)
  }
  !identical(status$Code %||% 0L, 0L)
}


handle_conditions <- function(resp) {
  if (has_failed(resp)) {
    code <- resp$Code
    msg <- sprintf("Error code %s: %s", code, resp$Content)
    stop(msg)
  }

  if (has_status(resp)) {
    code <- resp$Status$Code
    msg <- resp$Status$Content
    type <- resp$Status$Type
    msg <- sprintf("%s code %s: %s", type, code, msg)
    warning(msg, call. = FALSE)
  }
}
