# Sodium Utilities
# Non-exported utilities
#
# @details
# These utilities combine [base::serialize()] with [sodium::data_encrypt()] so
# that data can be written as an `rds` file. These do not handle the
# writing/reading.
#
# See [sodium_read()] and [sodium_write()] which make use of these functions.


sodium_encrypt <- function(object,key) {

  if( ! require(sodium) ) stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    serialize(., NULL)  ->.;
    sodium::data_encrypt(., sodium_make_key(key) )

}

sodium_decrypt <- function(object,key) {

  if( ! require(sodium) ) stop("The sodium is required for decrypting data sets.")

  object ->.;
    sodium::data_decrypt( ., sodium_make_key(key) ) ->.;
    unserialize(.)

}

# The key used must be converted.
sodium_make_key <- function(key) {
  key  ->.;
   charToRaw(.) ->.;
   sha256(.)
}
