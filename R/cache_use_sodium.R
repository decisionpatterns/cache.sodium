sodium_extension = 'sodium.rds'

#' Cache objects using sodium (Sodium) encryption
#'
#' Caches objects with sodium encryption using the *sodium* package
#'
#' @param key string; sets the en/decryption key `cache.sodium_key`.
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

  if( ! is.null(key) ) set_option( cache.sodium_key = key )

  if( is.null(getOption("cache.sodium_key") ) )
    set_option( cache.sodium_key = readline("Encryption key (sodium)? ") )


  options(
      cache.write    = cache_write_sodium
    , cache.read     = cache_read_sodium
    , cache.file_ext = sodium_extension
  )

}
