---
title: "README"
output: 
  html_document: 
    keep_md: true
date: "2024-06-10"
---



# openaiR <img src="man/figures/openaiR.png" align="right" alt="" width="120" />

[OpenAI Platform](https://platform.openai.com/docs/introduction) offers a range of models. These models can be easily used with the OpenAI Python package. However, detailed instructions on how to use them in R are not provided. The `openaiR` package offers a convenient way for social scientists to use two of the most useful APIs:

1. Chat Completion
2. Fetch Embeddings

The `openaiR` package simplifies the integration of OpenAI's powerful API into R workflows, making advanced natural language processing capabilities accessible to researchers and practitioners in the social sciences.


```r
#devtools::install_github("plumberDong/openaiR")
library(openaiR)
```


# Prerequisites

You need an OpenAI API key obtained from OpenAI **OR** an API key and endpoint provided by another intermediary platform.


```r
#--------------
# OpenAI API key
#--------------
#api_key <-  "sk-xxxxx"

#-------------------------
# API key and endpoint
#-------------------------
#api_key <- "sk-xxxxx"
#api_base_url <- "https://api.xxx.xxx/v1"
```

# Completions

The prompt can be a single text:


```r
x <- get_completions("I love you!", 
                     api_key = api_key, 
                     api_base_url = api_base_url) # if your OpenAI API key is obtained from OpenAI, just leave api_base_url parameter default
str(x)
```

```
## List of 7
##  $ id                : chr "chatcmpl-e8nt9GBIwe9TgZvGJYU0GIJaEJ5tY"
##  $ object            : chr "chat.completion"
##  $ created           : int 1718065721
##  $ model             : chr "gpt-3.5-turbo-0613"
##  $ choices           :'data.frame':	1 obs. of  3 variables:
##   ..$ index        : int 0
##   ..$ message      :'data.frame':	1 obs. of  2 variables:
##   .. ..$ role   : chr "assistant"
##   .. ..$ content: chr "Thank you! I'm here to help however I can. What's on your mind?"
##   ..$ finish_reason: chr "stop"
##  $ usage             :List of 3
##   ..$ prompt_tokens    : int 11
##   ..$ completion_tokens: int 18
##   ..$ total_tokens     : int 29
##  $ system_fingerprint: chr "fp_b28b39ffa8"
##  - attr(*, "class")= chr "COMPLETIONS"
```

The prompt can also be a list:


```r
prompt = list(
  list(
    role = "system",
    content = "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
  ),
  list(
    role = "user",
    content = "Compose a poem that explains the concept of recursion in programming."
  )
)

x <- get_completions(prompt, 
                     api_key = api_key, 
                     api_base_url = api_base_url)
str(x)
```

```
## List of 7
##  $ id                : chr "chatcmpl-PUejk7Y3FlaKEuEVKmHLsk6xHxmnF"
##  $ object            : chr "chat.completion"
##  $ created           : int 1718065723
##  $ model             : chr "gpt-3.5-turbo-0613"
##  $ choices           :'data.frame':	1 obs. of  3 variables:
##   ..$ index        : int 0
##   ..$ message      :'data.frame':	1 obs. of  2 variables:
##   .. ..$ role   : chr "assistant"
##   .. ..$ content: chr "In the realm where algorithms dance and code sings,\nThere lies a concept that spreads its wings.\nRecursion, t"| __truncated__
##   ..$ finish_reason: chr "stop"
##  $ usage             :List of 3
##   ..$ prompt_tokens    : int 39
##   ..$ completion_tokens: int 241
##   ..$ total_tokens     : int 280
##  $ system_fingerprint: chr "fp_b28b39ffa8"
##  - attr(*, "class")= chr "COMPLETIONS"
```

The response is a list with a complex structure, but sometimes we may only need the message it returns. We can use `extract_info` to simplify the received response:


```r
extract_info(x)
```

```
## [1] "In the realm where algorithms dance and code sings,\nThere lies a concept that spreads its wings.\nRecursion, the wizardry of loops unbound,\nA mystical force in the coder's playground.\n\nPicture a mirror reflecting its own reflection,\nA journey into depths, a recursive direction.\nIn programming parlance, a function calls its kin,\nCreating a loop where beginnings and ends begin.\n\nLike a matryoshka doll, nested layers unfold,\nEach call delving deeper, a story untold.\nA task divides, conquers, then calls itself anew,\nUntil the base case whispers, \"This is through.\"\n\nA whispering wind through the branches of a tree,\nEach node birthing branches, a recursive decree.\nFrom trunk to twig, it branches out its tale,\nIn a recursive embrace, where patterns prevail.\n\nThrough Fibonacci's sequence, nature's rhythmic flow,\nRecursive echoes in numbers that grow.\nA spiral dance of golden ratio's grace,\nIn each recursive step, a glimpse of its face.\n\nSo let your mind wander in recursive delight,\nWhere problems unravel in the depths of night.\nFor in the world of code, where logic reigns supreme,\nRecursion whispers secrets in an endless dream."
```


# Embeddings

The input_text should be a single text:


```r
x <- get_embeddings(input_text = "I LOVE YOU, openaiR！",
                    api_key = api_key,
                    api_base_url = api_base_url)
str(x)
```

```
## List of 4
##  $ object: chr "list"
##  $ data  :'data.frame':	1 obs. of  3 variables:
##   ..$ object   : chr "embedding"
##   ..$ index    : int 0
##   ..$ embedding:List of 1
##   .. ..$ : num [1:3072] 0.00539 -0.02682 -0.0196 -0.00921 0.00256 ...
##  $ model : chr "text-embedding-3-large"
##  $ usage :List of 2
##   ..$ prompt_tokens: int 8
##   ..$ total_tokens : int 8
##  - attr(*, "class")= chr "EMBEDDINGS"
```

If we only need the embeddings it returns, we can use `extract_info` to simplify it:


```r
res <- extract_info(x)
str(res)
```

```
##  num [1:3072] 0.00539 -0.02682 -0.0196 -0.00921 0.00256 ...
```

As we can see, the default model "text-embedding-3-large" returns a vector with 3072 dimensions! Storing or analyzing such a long vector can be challenging, especially when dealing with many pieces of text. In certain cases, you may need to change the embedding dimensions after generating them.

According to [OpenAI](https://platform.openai.com/docs/guides/embeddings/use-cases), the new embedding models were trained with a technique that allows developers to shorten embeddings without losing their concept-representing properties. The openaiR package adopts their methods and integrates the whole process into the `prune_embeddings` function:


```r
prune_res <- prune_embeddings(embeddings = res, 
                              #n dim: the number of dimensions you wanted.
                              ndim = 256)
str(prune_res)
```

```
##  num [1:256] 0.01384 -0.06887 -0.05032 -0.02364 0.00658 ...
```













