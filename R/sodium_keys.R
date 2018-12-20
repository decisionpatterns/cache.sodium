#' sodium key management
#'
#' Get and set the key for encryption and decryption
#'
#' @param key string for encryption key
#'
#' @details
#'
#' [sodium_set_key()] sets the encryption key to `key`. It is stored as an option:
#' 'cache.sodium.key'
#'
#' [sodium_get_key()] retrieves the key. It returns NULL if no key has been set.
#'
#' [sodium_get_key_or_ask()] retrieves the key. If no key has been set and the
#' session is interactive, the user is prompted for the key.
#'
#' [cache_sodium_key()] can be used to set the sodium key if `key` is provided.
#' Otherwise it is retrieved.  This matches the *cache-style* accessors.
#'
#' @examples
#'
#'   sodium_set_key('xyzzy')
#'   sodium_get_key()
#'   sodium_set_key(NULL)
#'   sodium_get_key()
#'
#' \dontrun{
#'   sodium_get_key_or_ask()
#'   sodium_get_key()
#' }
#'
#' @rdname sodium_keys
#' @export

sodium_set_key <- function(key) {
  # key <- sodium_make_key(key)
  set_option( cache.sodium.key = key  )
}

#' @rdname sodium_keys
#' @export

sodium_get_key <- function() get_option('cache.sodium.key')


#' @rdname sodium_keys
#' @export

sodium_get_key_or_ask <- function() {

  key <- sodium_get_key()
  if( is.null(key) && interactive() ) {
    key <- readline("sodium encryption key? " )
    set_option( cache.sodium.key = key )
  }

  if( is.null(key) )
    stop( "cache.sodium.key is NULL. Set it using `cache_set_key`.")

  key
}


sodium_ask_key <- function() {

  if( ! interactive() ) return(NULL)
    # stop("Asking for a key is only allowed in interactive sessions.")

  sodium_set_key( readline("sodium encryption key? " ) )

}


#' @rdname sodium_keys
#' @export

cache_sodium_key <- function(key=NULL)
  if( is.null(key) )
    return( sodium_get_key() ) else sodium_set_key()



