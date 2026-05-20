#' @title Print yadir_token
#' @description S3 method for printing yadir_token objects
#' @param x yadir_token object
#' @param ... extra arguments
#' @export
print.yadir_token <- function(x, ...) {
  
  cat('Yandex Direct Token:\nExpire at', format(x$expire_at, '%Y-%m-%d %T %Z (UTC %z)'))
  
}