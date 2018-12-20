#' Register sodium as a backend for cache
#'
#' Installs `cache.sodium` for use as an extension for writing/reading files
#'
#' @details
#'
#' You probably should use [cache_use_sodium()] instead which makes sodium
#' the default method for reading/writing to the cache.  There is generally no
#' reason to invoke this function as it is called when the packages is
#' attached.
#'
#' @seealso
#'  - [cache_use_sodium()]
#'
#' @import cache
# @export

cache_register_sodium <- function() {

  if( interactive() )
    message(  "Registering 'cache.sodium' as a cache backend.\n"
          , "  Use 'cache_use_sodium()' to set it as the default."
    )

  cache::cache_backend_register(
      name = 'sodium'
    , ext = EXTENSION
    , pkg = PKG
    , reader = read_sodium
    , writer = write_sodium
  )

}
