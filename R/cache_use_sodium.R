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

  if( ! is.null(key) ) set_option( cache.sodium.key = key )

  if( is.null(getOption("cache.sodium.key") ) )
    set_option( cache.sodium.key = readline("Encryption key (sodium)? ") )

  cache_register_sodium()
  cache_default('sodium')

}

#' @rdname cache_use_sodium
#' @export

cache_sodium_key <- function(key=NULL)
  if( is.null(key) ) return( get_option('cache.sodium.key') ) else
    options(cache.sodium.key = key )

