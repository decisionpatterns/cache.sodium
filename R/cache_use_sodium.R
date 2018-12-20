#' Cache objects using sodium (Sodium)
#'
#' Caches objects with sodium encryption using the *sodium* package
#'
#' @param key string; sets the en/decryption key `cache.sodium.key`.
#'   The default (NULL) does not set a key.
#'
#' @details
#'
#' Encrypts cached datasets using sodium256 encryption provided by the *sodium*
#' package. Cache
#'
#' If `key` is provided, this is used as the encryption/decrytion key.
#'
#' @examples
#'
#' dontrun{
#'  cache_use_sodium()
#'  cache(mtcars)
#'  if( exists('mtcars') ) rm(mtcars)
#'  uncache(mtcars)
#'  fs::dir_ls( cache_find() )
#' }
#'
#' @export

cache_use_sodium <- function(key=NULL) {

  if( ! require(sodium) )
    stop("\n`cache_use_sodium` requires the sodium packages. Install it with:\n\tinstall.packages('sodium')")

  # SET DE/ENCRYPTION KEY
  if( ! is.null(key) )
    sodium_set_key(key) else
    sodium_ask_key()

  cache_register_sodium()
  cache_backend('sodium')

}
