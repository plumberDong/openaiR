#' Get embeddings using OpenAI API
#' @description
#' This function retrieves embeddings for a given text using the OpenAI API. It provides a simple interface for embedding text into a vector space, which can be useful for a variety of natural language processing tasks. For more details, see "https://platform.openai.com/docs/guides/embeddings."
#'
#' @param input_text The text to get embeddings for. Must be a character vector.
#' @param api_key Your OpenAI API key.
#' @param api_base_url The base URL for the API (default is "https://api.openai.com/v1/embeddings").
#' @param model A model to use for embeddings (default is "text-embedding-ada-002").
#' @param max_tries An integer specifying the maximum number of retry attempts for the API call. Defaults to 1.
#' @return A list object containing embeddings.
#' @export
#' @import httr2
#' @importFrom jsonlite fromJSON
#' @examples
#' # Example(Not run)
#' # x <- get_embeddings(input_text, api_key = "xxx", api_base_url = "xxx")

get_embeddings <- function(input_text, api_key,
                           api_base_url = "https://api.openai.com/v1",
                           model = "text-embedding-3-large",
                           max_tries = 1){

  # API key validation
  if (is.null(api_key) || api_key == "") {
    stop("API key is required. Please provide a valid API key.")
  }

  # Input text validation
  if (is.null(input_text) || input_text == "") {
    stop("Input text is required. Please provide valid input text.")
  }

  # Ensure input_text is a character vector
  if (!is.character(input_text)) {
    stop("Input text must be a character vector.")
  }

  # embeddings url
  api_base_url <- paste0( api_base_url, "/embeddings")

  # get response
  req <- request(api_base_url) |>
    req_headers(
      "Content-Type" = "application/json",
      "Authorization" = paste("Bearer", api_key)
    ) |>
    req_body_json(list(
      input = input_text,
      model = model
    )) |>
    req_retry(max_tries = max_tries)
  response <- req_perform(req)
  response <- resp_body_string(response) |> fromJSON()

  return(structure(response, class = "EMBEDDINGS"))
}

