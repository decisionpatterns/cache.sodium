# test-cache.R

library(cache)

data(iris)
key <- "my-key"
c_path <- "./cache"

context('cache')

# cache::cache_create(c_path)
use_cache()
cache_use_sodium(key)

cache(iris)
i2 <- uncache(iris)

expect_equal(iris, i2)

# Clean-up
cache_delete(c_path)
expect_false( fs::dir_exists( c_path ) )
