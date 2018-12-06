#' Read cache using sodium
#'
#' @param name string; name of object in the cache
#' @param cache string; path to cache directory. Defaults to [cache_find()]
#' @param key string; key for writing and resotring
#'
#' @details
#'
#' `cache_read_sodium` reads an AES encrypted object from the cache. `AES`
#' encrypted objects are
#'
#' @importFrom sodium data_decrypt
#' @importFrom fs path
#' @importFrom fs path_ext_set
#' @export

cache_read_sodium <- function(
    name
  , cache = cache_find()
  , key = getOption("cache.sodium.key", set_option( cache.sodium.key = readline("sodium Encryption Key? ") ) )
) {

  if( ! require(sodium) ) stop("The sodium is required for decrypting data sets.")

  path <- {
    cache ->.;
      fs::path( ., name ) ->.;
      if( path_ext(.) == '' )
        fs::path_ext_set( ., sodium_extension ) else
        paste( . , sodium_extension, sep = ".")
    }

  path  ->.;
    readRDS(.) ->.;
    sodium_decrypt(., key)

}


