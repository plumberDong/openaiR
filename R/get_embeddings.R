#' get embeddings using openAI api
#' @description
#' This function retrieves embeddings for a given text using the OpenAI API. It provides a simple interface for embedding text into a vector space, which can be useful for a variety of natural language processing tasks. For more details, see "https://platform.openai.com/docs/guides/embeddings."
#'
#' @param input_text The text to get embeddings for.
#' @param api_key Your OpenAI API key.
#' @param api_base_url The base URL for the API (default is "https://api.openai.com/v1/embeddings").
#' @param model A model to use for embeddings (default is "text-embedding-ada-002")
#' @param max_tries Automatically retry if the request fails.
#'
#' @return A list object containing embeddings.
#' @export
#' @import httr2
#' @importFrom jsonlite fromJSON
get_embeddings <- function(input_text, api_key,
                           api_base_url = "https://api.openai.com/v1/embeddings",
                           model = "text-embedding-ada-002",
                           max_tries = 1){

  # API exists?
  if (is.null(api_key) || api_key == "") {
    stop("API key is required. Please provide a valid API key.")
  }

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

