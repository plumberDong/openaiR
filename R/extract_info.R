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


#' Generic Method for COMPLETIONS
#'
#' @param object A COMPLETIONS object containing response of system
#' @param ... Additional arguments (ignored)
#' @return An character object
#' @export
extract_info.COMPLETIONS <- function(object, ...) {
  if (!is.list(object)) {
    stop("Invalid data structure in COMPLETIONS object")
  }
  return(object$choices$message$content[[1]])
}
