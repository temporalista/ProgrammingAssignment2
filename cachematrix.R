##'This script computes the inverse of a matrix. It takes advantage of lexical
##'scoping rules in R to cache the result and reuse it if the original matrix
##'remains the same.
##'This is the second assignment of "R Programming" course.


## This function creates a special "Cache Matrix" which returns four functions to set and get both the original matrix (om) and the inverse matrix (im)
makeCacheMatrix <- function(x = matrix()) {
        
        #placeholder for inverse matrix
        im <- NULL 
       
        # uses lexical scooping to assign values to 'x' and 'im' in the global
        # environment. When setom is used, the cached inverse matrix is set to NULL 
        setom  <- function (y){
                x <<- y
                im <<- NULL 
        }
        
        #returns the original matrix
        getom <- function() x
        
        #set the inverse matrix 
        setim <- function(solve) im  <<- solve
        
        #returns the inverse matrix 
        getim <- function() im
        
        #create a lists with the four functions
        list(
                setom = setom,
                getom = getom,
                setim = setim,
                getim = getim
                
                )
        

}


## This function computes and caches the inverse of the matrix (if the inverse 
## matrix already exists in the cache, it skips the computation and returns the
## content of the cache).

cacheSolve <- function(x, ...) {
        
        # assigns to 'im' the inverse matrix via the getim function
        im <- x$getim()
        
        #if the inverse matrix already exists, returns is content
        if (!is.null(im)){
                message("getting cached matrix")
                return(im)
                
        }
        
        #get the original matrix via the getom function
        data <- x$getom()
        
        #computes the inverse of the matrix
        im <- solve(data,...)
        
        #assign the invese matrix to 'im'
        x$setim(im)
        
        #returns 'im'
        im
        
}


