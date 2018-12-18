#' @param object object to store.
#' @param path string; path to object
#' @param cache string; path to cache directory. Defaults to [cache_find()]
#' @param key string; encrypton key. Defaults to option cache.sodium_key
#'
#' @details
#'
#' `cache_write_sodium` and `cache_read_sodium` are functions for
#' reading and writing sodium encrypted objects to/from the cache. In most cases,
#' [cache()] and [uncache()] should be used with [cache_set_sodium()] instead.
#'
#'
#' The extension given to sodium encrypted files is `sodiumrds`.
#'
#' @return
#'   `object` (In order to be pipe-able, the object must be returned)
#'
#' @examples
#'   cache_write_sodium( iris, "my key" )
#'   cache_read_sodium( 'iris', "my key" )
#'
#' @importFrom sodium data_encrypt
#' @importFrom sodium data_decrypt
#' @rdname cache_use_sodium
#' @export

write_sodium <- function(
    object
  , path
  , key = getOption( "cache.sodium.key", set_option( cache.sodium_key = readline("sodium Encryption Key? ") ) )
  , ...
) {

  if( ! require(sodium) ) stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    sodium_encrypt(., key) ->
    write_this

  write_rds( write_this, path, ... )

}
