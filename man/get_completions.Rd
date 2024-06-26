% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_completions.R
\name{get_completions}
\alias{get_completions}
\title{Get completions using OpenAI API}
\usage{
get_completions(
  prompt,
  api_key,
  api_base_url = "https://api.openai.com/v1",
  model = "gpt-3.5-turbo",
  max_tries = 1,
  ...
)
}
\arguments{
\item{prompt}{A character vector or a list of messages in the format required by the OpenAI API. If a character vector is provided, it will be converted to a list.}

\item{api_key}{A string containing your OpenAI API key.}

\item{api_base_url}{A string containing the base URL for the OpenAI API. Defaults to "https://api.openai.com/v1/chat/completions".}

\item{model}{A string specifying the model to use. Defaults to "gpt-3.5-turbo".}

\item{max_tries}{An integer specifying the maximum number of retry attempts for the API call. Defaults to 1.}

\item{...}{Additional parameters to pass to the API request.}
}
\value{
A list object containing the response from the system.
}
\description{
This function retrieves completions for a given prompt using the OpenAI API. It provides a simple interface for generating text completions, which can be useful for a variety of natural language processing tasks. For more details, see "https://platform.openai.com/docs/guides/completions."
}
\examples{
# Example(Not run)
# Text
# x <- get_embeddings("I Love you", api_key = "xxx", api_base_url = "xxx")
#
# List
# message = list(
# list(
#   role = "system",
#   content = "You are a poetic assistant"
# ),
# list(
#   role = "user",
#  content = "Compose a poem."
#  )
#)
# x <- get_embeddings(message, api_key = "xxx", api_base_url = "xxx")
}
