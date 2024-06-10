#' Generic Function
#'
#' @param object An object
#' @param ... Additional arguments (ignored)
#' @export
extract_info <- function(object, ...) {
  UseMethod("extract_info")
}

#' Generic Method for EMBEDDINGS
#'
#' @param object A EMBEDDINGS object containing embeddings data
#' @param ... Additional arguments (ignored)
#' @return An embeddings vector.
#' @export
extract_info.EMBEDDINGS <- function(object, ...) {
  if (!is.list(object)) {
    stop("Invalid data structure in EMBEDDINGS object")
  }
  return(object$data$embedding[[1]])
}
