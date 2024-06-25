z22_cache <- new.env(parent = emptyenv())

#' Authenticate
#' @description
#' Stores Zensus2022 login credentials or tokens to access API methods that
#' require authentication. Login credentials are securely stored using
#' the \code{\link{keyring}} package and are automatically retrieved to
#' make authenticated requests.
#'
#' \code{z22_auth} supports authentication using an an API token or
#' using credentials (i.e. username and password). If an API token is
#' provided, it is stored inside an R environment for further use.
#' If a username and a password function is provided, the password is
#' created by executing the password function. It is then stored in a keyring.
#'
#' @param token API token that can be retrieved from the
#' \href{https://ergebnisse2011.zensus2022.de/datenbank/online}{Zensus 2022 database}.
#' @param username Zensus2022 username.
#' @param password Function that prompts a password entry. Defaults to
#' \code{\link[askpass]{askpass}}.
#'
#' @returns \code{NULL}, invisibly.
#'
#' @seealso \code{\link{z22_is_auth}}
#'
#' @examples
#' \dontrun{
#' # authenticate using a token
#' z22_auth(token = "XXXxxXXxxXX")
#'
#' # verify that the authentication worked
#' z22_is_auth()
#'
#' # authenticate using credentials
#' z22_auth(username = "user")
#'
#' # using a different password prompt
#' z22_auth(username = "user", password = rstudioapi::askForPassword)
#' }
z22_auth <- function(token = NULL,
                     username = NULL,
                     password = askpass::askpass) {
  if (.has_auth()) {
    return()
  }

  if (!is.null(token)) {
    check_string(token)
    assign("token", token, envir = z22_cache)
  } else if (!is.null(username)) {
    check_string(username)
    check_class(password, "function")
    password <- password()
    assign("username", username, envir = "z22_cache")
    keyring::key_set_with_value("z22", username = username, password = password)
  } else {
    stop("Either a token or a username must be provided.")
  }

  invisible()
}


#' Verify authentication
#' @description
#' Verify authentication using \code{\link{z22_auth}} by querying the
#' \code{logincheck} method.
#'
#' @param error Whether to throw an error if authentication failed.
#' If \code{FALSE}, returns a logical value.
#'
#' @returns A logical value indicating whether the authentication was
#' successful. If \code{error = TRUE}, throws an error if this value is
#' \code{FALSE}.
#'
#' @export
#'
#' @seealso \code{\link{z22_auth}}
#'
#' @examples
#' \dontrun{
#' # authenticate
#' z22_auth(token = "XXXxxXXxxXX")
#'
#' # verify that the authentication worked
#' z22_is_auth()
#'
#' # use to gatekeep further analysis
#' # if authentication fails, aborts operation before
#' # other methods are requested
#' z22_is_auth(error = TRUE)
#' z22_find()
#' }
z22_is_auth <- function(error = FALSE) {
  params <- .make_params(auto = FALSE)
  res <- request_zensus(
    service = "helloworld",
    method = "logincheck",
    params = params
  )

  failed <- any(startsWith(res$Status, auth_errors))
  if (failed && error) {
    stop(res$Status)
  }

  !failed
}


has_token <- function() {
  exists("token", envir = z22_cache)
}


has_credentials <- function() {
  username <- get0("username", envir = z22_cache, ifnotfound = "")
  keys <- keyring::key_list()
  has_pw <- "z22" %in% keys[keys$username %in% username, ]
}


.has_auth <- function() {
  has_token() || has_credentials()
}


check_auth <- function() {
  if (!.has_auth()) {
    stop(paste(
      "z22 is not authenticated.",
      "Please run z22_auth to login to the Zensus2022 database."
    ))
  }
}


.get_auth <- function() {
  check_auth()

  if (has_token()) {
    list(username = get("token", envir = z22_cache))
  } else {
    username <- get("username", envir = z22_cache)
    password <- as.character(keyring::key_get("z22", username = username))
    list(username = username, password = password)
  }
}


.make_params <- function(..., auto = TRUE, env = parent.frame()) {
  if (auto && !...length()) {
    params <- as.list(env)
  } else {
    params <- list(...)
  }

  language <- list(language = getOption("z22_language", "en"))
  cred <- .get_auth()
  params <- drop_empty(drop_null(params))
  c(cred, language, params)
}


auth_errors <- c(de = "Ein Fehler ist aufgetreten", en = "An error occurred")
