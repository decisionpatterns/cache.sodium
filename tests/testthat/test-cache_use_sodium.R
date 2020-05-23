# test-cache_use_sodium.R

key = "my-key"

context('cache_use_sodium')
cache_use_sodium(key)

cache_backend() ->.;  expect_equal( ., "sodium" )
