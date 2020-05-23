# test-sodium_read.R

data(iris)
key <- 'my-key'


context('sodium_write and sodium_read')

sodium_write( iris, 'iris.rds', key )
i2 <- sodium_read( 'iris.rds', key )
expect_identical(iris, i2)

# Clean-up
fs::file_delete('iris.rds')
