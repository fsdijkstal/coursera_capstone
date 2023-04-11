

library(shiny)
library(tidytext)
library(dplyr)
library(readr)
library(stringr)

unigrams = read_csv('unigrams.csv')
bigrams = read_csv('bigrams.csv')
trigrams = read_csv('trigrams.csv')

predict_word = function(x, y, n = 100) {
  # prediction with no input
  if(x == "" & y == ""){
    predict_word = unigrams
    
    # prediction with two words
  } else if(x %in% trigrams$word1 & y %in% trigrams$word2) {
    predict_word = trigrams %>%
      filter(word1 %in% x & word2 %in% y) %>%
      select(word3)
    
    # prediction with one word
  } else if(y %in% bigrams$word1) {
    predict_word = bigrams %>%
      filter(word1 %in% y) %>%
      select(word2)
    
    # if no prediction found, fall back to unigrams 
  } else{
    predict_word = unigrams %>%
      select(word)
  }
  
  return(predict_word[1:n, ])
  
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    prediction = reactive( {
      
      input = str_remove_all(input$text, '[[:punct:]]')
      word1 = word(input, -2)
      word2 = word(input, -1)
      
      prediction = predict_word(word1, word2)
      
    })
    
    output$table = renderDataTable(prediction(), 
                                   option = list(pageLenght = 2,
                                                 searching = F))

})
