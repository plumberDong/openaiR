#' Get completions using OpenAI API
#' @description
#' This function retrieves completions for a given prompt using the OpenAI API. It provides a simple interface for generating text completions, which can be useful for a variety of natural language processing tasks. For more details, see "https://platform.openai.com/docs/guides/completions."
#' @param prompt A character vector or a list of messages in the format required by the OpenAI API. If a character vector is provided, it will be converted to a list.
#' @param api_key A string containing your OpenAI API key.
#' @param api_base_url A string containing the base URL for the OpenAI API. Defaults to "https://api.openai.com/v1/chat/completions".
#' @param model A string specifying the model to use. Defaults to "gpt-3.5-turbo".
#' @param max_tries An integer specifying the maximum number of retry attempts for the API call. Defaults to 1.
#' @param ... Additional parameters to pass to the API request.
#' @import httr2
#' @importFrom jsonlite fromJSON
#' @return A list object containing the response from the system.
#' @export
#'
#' @examples
#' # Example(Not run)
#' # x <- get_embeddings("I Love you", api_key = "xxx", api_base_url = "xxx")
#' #. api_base_url3 = "https://api.xty.app/v1/chat/completions"
#' # message = list(
#' # list(
#' #   role = "system",
#' #   content = "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
#' # ),
#' # list(
#' #   role = "user",
#' #  content = "Compose a poem that explains the concept of recursion in programming."
#' #  )
#' #)
get_completions <- function(prompt,
                            api_key,
                            api_base_url = "https://api.openai.com/v1/chat/completions",
                            model = "gpt-3.5-turbo",
                            max_tries = 1, ...){

  # API exists?
  if (is.null(api_key) || api_key == "") {
    stop("API key is required. Please provide a valid API key.")
  }

  # prompt exists?
  if (is.null(prompt) || api_key == "") {
    stop("Prompt is required. Please provide a valid API key.")
  }

  # message is list or single text?
  if (is.character(prompt)){
    prompt <- list(
      list(role = "user", content = prompt)
    )
  }

  # Convert ... to list
  extra_params <- list(...)

  # Merge prompt and model with extra_params
  body_params <- utils::modifyList(list(messages = prompt, model = model), extra_params)

  # get response
  req <- request(api_base_url) |>
    req_headers(
      "Content-Type" = "application/json",
      "Authorization" = paste("Bearer", api_key)
    ) |>
    req_body_json(body_params) |>
    req_retry(max_tries = max_tries)

  response <- req_perform(req)
  response <- resp_body_string(response) |> fromJSON()

  return(structure(response, class = "COMPLETIONS"))
}
