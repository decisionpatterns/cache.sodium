# Utilities (Not exported)

sodium_encrypt <- function(object,key) {

  if( ! require(sodium) ) stop( "The sodium is required for encrypting data sets.")

  object  ->.;
    serialize(., NULL)  ->.;
    data_encrypt(., sodium_make_key(key) )

}

sodium_decrypt <- function(object,key) {

  if( ! require(sodium) ) stop("The sodium is required for decrypting data sets.")

  object ->.;
    data_decrypt( ., sodium_make_key(key) ) ->.;
    unserialize(.)

}

# The key used must be converted.
sodium_make_key <- function(key) {
  key  ->.;
   charToRaw(.) ->.;
   sha256(.)
}
