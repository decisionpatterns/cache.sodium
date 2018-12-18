
get_option <- getOption


# (Pipeable) set single options
#
# @return
#   The options value, invisibly
#
# @examples
#
#  x <- set_option( cache_key = "my key" )
#  x
#  getOption("cache_key")

set_option <- function(...) {

  li <- list(...)

  if( length(li) != 1 ) stop("Options must be a single name/value pair.")
  if( is.null(names(li)) ) stop( "Options must be named")

  options(...)

  invisible( li[[1]] )
}
