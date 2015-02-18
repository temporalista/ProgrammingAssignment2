# Test your code
source("cachematrix.R")
#
# generate matrix, and the inverse of the matrix.
size <- 1100 # size of the matrix edge, don't make this too big
mymatrix <- matrix(rnorm(size^2), nrow=size, ncol=size)
mymatrix.inverse <- solve(mymatrix)
#
# now solve the matrix via the cache-method
#
special.matrix   <- makeCacheMatrix(mymatrix)
#
# this should take long, since it's the first go
start1 <- Sys.time ()
special.solved.1 <- cacheSolve(special.matrix)
end1 = Sys.time () - start1
#
# this should be lightning fast
start2 <- Sys.time ()
special.solved.2 <- cacheSolve(special.matrix)
end2 = Sys.time () - start2
#
# check if all solved matrices are identical
print(identical(mymatrix.inverse, special.solved.1) & identical(mymatrix.inverse, special.solved.2))
#
# should return TRUE
#
# Display the execution times for each approach:
print(end1)
print(end2)
###############################################



##test 2
## Track what happens when you modify the contents of the matrix:
#First create a new matrix:
mymatrix2 <- matrix(rnorm(size^2), nrow=size, ncol=size)
mymatrix2.inverse <- solve(mymatrix2)

#Then modify the contents of the the special matrix using the 'set' function: 
special.matrix$setom(mymatrix2)

#Now use cacheSolve. You should NOT see 'getting cached data' in your console because the matrix contents are now modified:
special.solved.3 = cacheSolve(special.matrix)

#The following should return FALSE, because now you have a new inverse value:
print(identical(mymatrix.inverse, special.solved.3))
#But this should return TRUE:
print(identical(mymatrix2.inverse, special.solved.3))

#If you cacheSolve again, you should now see 'getting cached data' in the console.
special.solved.4 = cacheSolve(special.matrix)

#And this should return TRUE:
print(identical(mymatrix2.inverse, special.solved.4))
