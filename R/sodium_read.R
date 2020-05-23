#' Read and write using sodium
#'
#' Reads or writes a file using sodium encryption
#'
#' @param path string; path to
#' @param key string; encryption key
#'
#' @details
#' [sodium_read()] reads a sodium encrypted object at path.
#'
#' @importFrom sodium data_decrypt
#' @importFrom fs path
#' @importFrom fs path_ext_set
#' @export

sodium_read <- function(
    path
  , key = sodium_get_key_or_ask()
) {

  read_rds(path) ->.;
    sodium_decrypt(., key)

}

#' @param object object to store.
#' @param ... additional arguments sent to [base::readRDS()]
#'
#' @details
#' [sodium_write()] stores an encrypted object to the path.

#' In most cases,[cache::cache()] / [cache::uncache()] and
#' [cache::cache_write()]/[cache::cache_read()] should be used.
#'
#' The extension given to sodium encrypted files is `sodium.rds`.
#'
#' @return
#'   `object` (In order to be pipe-able, the object must be returned)
#'
#' @examples
#'   sodium_write( iris, 'iris.rds', "my key" )
#'   sodium_read( 'iris.rds', "my key" )
#'
#' @importFrom sodium data_encrypt
#' @importFrom sodium data_decrypt
#' @rdname sodium_read
#' @export

sodium_write <- function(
    object
  , path
  , key = sodium_get_key_or_ask()
  , ...
) {

  if( ! require(sodium) )
    stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    sodium_encrypt(., key) ->
    write_this

  # side-effect
  write_rds( write_this, path, ... )

 invisible(object)

}

