# Utilities (Not exported)


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
