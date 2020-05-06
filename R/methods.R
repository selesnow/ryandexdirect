print.yadir_token <- function(x, ...) {
  
  cat('Yandex Direct Token:\nExpire at', format(x$expire_at, '%Y-%m-%d %T %Z (UTC %z)'))
  
}