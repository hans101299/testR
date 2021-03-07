install.packages("tm")
install.packages("wordcloud")
install.packages("wordcloud2")
library(wordcloud)
library(pacman)
p_load(tm,wordcloud)
library(tidyverse)
getwd()
dir.create('wordcloud')
download.file("https://ibm.box.com/shared/static/cmid70rpa7xe4ocitcga1bve7r0kqnia.text",
              destfile = "wordcloud/churchill_speeches.text", quiet =TRUE)
library(devtools)
devtools::install_github("lchiffon/wordcloud2")
dirPath= "wordcloud/"
speech = Corpus(DirSource(dirPath))

inspect(speech)

speech = tm_map(speech, content_transformer(tolower)) 
speech = tm_map(speech, removeNumbers)
speech = tm_map(speech, removeWords,stopwords('english'))
speech = tm_map(speech, removeWords, 
                c("floccinaucinihilipification", "squirrelled"))
speech = tm_map(speech, removePunctuation)
#create a Term Document Matrix
attach(d)
dtm = TermDocumentMatrix(speech)
#Matrix transformation
m= as.matrix(dtm) 
# Sort it to show the most frequent words 
v=sort(rowSums(m),decreasing = TRUE)
# transform to a data frame 
d= data.frame(word=names(v), freq =v)
words1 = d$word

wordcloud(words=d$word,freq=d$freq, 
          min.freq = 1, max.words = 250,
          colors = brewer.pal(8,"Dark2"),
          random.order = FALSE,
          fixed.asp = FALSE, 
          rot.per=0)
wordcloud2(d, figPath = "wordcloud/M2jeo.jpg", size = 0.7)
wordcloud2(d, size = 0.7, shape = 'cardioid')
?wordcloud2
devtools::install_github("ricardo-bion/ggradar", 
                         dependencies = TRUE)
