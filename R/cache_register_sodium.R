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
  message('sodium registered as a cache backend.')
  cache::cache_backend_register(
      name = 'sodium'
    , ext = extension
    , reader = read_sodium
    , writer = write_sodium
    , pkg = pkg
  )
}
