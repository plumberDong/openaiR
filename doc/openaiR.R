## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
#  x <- get_completions("I love you!",
#                       api_key = api_key,
#                       api_base_url = api_base_url) # if your OpenAI API key is obtained from OpenAI, just leave api_base_url parameter default
#  str(x)

## ----eval=FALSE---------------------------------------------------------------
#  prompt = list(
#    list(
#      role = "system",
#      content = "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
#    ),
#    list(
#      role = "user",
#      content = "Compose a poem that explains the concept of recursion in programming."
#    )
#  )
#  
#  x <- get_completions(prompt,
#                       api_key = api_key,
#                       api_base_url = api_base_url)
#  str(x)

## ----eval=FALSE---------------------------------------------------------------
#  extract_info(x)

## ----eval=FALSE---------------------------------------------------------------
#  x <- get_embeddings(input_text = "I LOVE YOU, openaiR！",
#                      api_key = api_key,
#                      api_base_url = api_base_url)
#  str(x)

## ----eval=FALSE---------------------------------------------------------------
#  res <- extract_info(x)
#  str(res)

## ----eval=FALSE---------------------------------------------------------------
#  prune_res <- prune_embeddings(embeddings = res,
#                                #n dim: the number of dimensions you wanted.
#                                ndim = 256)
#  str(prune_res)

