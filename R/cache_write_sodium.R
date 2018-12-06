#' @title Cache objects using sodium (Sodium) encryption
#'
#' @description
#' Caches objects with sodium encryption using the *sodium* package
#'
#' @param key string; sets the en/decryption key `cache.sodium_key`.
#'   The default (NULL) does not set a key.
#'
#' @details
#'
#' Encrypts cached datasets using sodium256 encryption provided by the *sodium*
#' package.
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


#' @rdname cache_use_sodium
#' @export

cache_use_aes <- function(...) {
  .Deprecated("cache_use_sodium", "cache")
  cache_use_sodium(...)
}




#' @param name string; name of object in the cache
#' @param cache string; path to cache directory. Defaults to [cache_find()]
#'
#' @details
#'
#' `cache_read_sodium` reads an AES encrypted object from the cache. `AES`
#' encrypted objects are
#'
#' @importFrom sodium data_decrypt
#' @importFrom fs path
#' @importFrom fs path_ext_set
#' @rdname cache_use_sodium
#' @export

cache_read_sodium <- function(
    name
  , cache = cache_find()
  , key = getOption("cache.sodium_key", set_option( cache.sodium_key = readline("sodium Encryption Key? ") ) )
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





# Utilities (Not exported)

sodium_extension = 'aesrds'

make_sodium_key <- function(key) {

  key  ->.;
   charToRaw(.) ->.;
   sha256(.)

}


sodium_encrypt <- function(object,key) {

  if( ! require(sodium) ) stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    serialize(., NULL)  ->.;
    data_encrypt(., make_sodium_key(key) )

}

sodium_decrypt <- function(object,key) {

  if( ! require(sodium) ) stop("The sodium is required for decrypting data sets.")

  object ->.;
    data_decrypt( ., make_sodium_key(key) ) ->.;
    unserialize(.)

}
