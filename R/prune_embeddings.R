#' reducing embedding dimensions
#' @description
#' embeddings can be shortened to a size of ndim while still outperforming an unshortened version!
#' @param embeddings A vector, your embeddings
#' @param ndim the number of dimensions you wanted.(default is 256)
#'
#' @return An unit vector.
#' @export
#'
#' @examples
#' x <- prune_embeddings(embeddings = x, ndim = 256)
prune_embeddings <- function(embeddings, ndim = 256) {
  # Check if embeddings is a numeric vector
  if (!is.numeric(embeddings)) {
    stop("Embeddings should be a numeric vector.")
  }

  # Check if ndim is a positive integer
  if (!is.numeric(ndim) || ndim <= 0 || ndim != as.integer(ndim)) {
    stop("ndim should be a positive integer.")
  }

  # Ensure the length of embeddings is at least ndim
  if (length(embeddings) < ndim) {
    stop("The dimension of your embeddings is less than ndim required.")
  }

  # Prune the embeddings to the desired number of dimensions
  x <- embeddings[1:ndim]

  # Normalize the pruned vector
  norm <- sqrt(sum(x^2))

  # Handle the case where the norm is zero
  if (norm == 0) {
    warning("The norm of the embeddings is zero. Returning the original pruned embeddings.")
    return(x)
  }

  return(x / norm)
}
