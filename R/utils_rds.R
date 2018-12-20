# RDS Utilities
# Non-exported utilities

write_rds <- function( object, path, ... ) {
  saveRDS( object, file=path, ... )
  invisible(object)
}

read_rds <- readRDS
