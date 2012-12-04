# load in scraped data
print(load(file.path("./data", 'cta.handle.RData')))
print(load(file.path("./data", 'cta.hash.RData' )))

pos.words <- scan(file.path("./data", 'opinion-lexicon-English', 'positive-words.txt'), what='character', comment.char=';')
neg.words <- scan(file.path("./data", 'opinion-lexicon-English', 'negative-words.txt'), what='character', comment.char=';')


# add in some extra words relvant to cta

# add a few twitter and industry favorites
pos.words <- c(pos.words, 'fast', 'efficient' )
neg.words <- c(neg.words, 'wtf', 'wait', 'waiting', 'epicfail', 'mechanical', 'express', 'stuck', 'packed', 'crowded', 'bears', 'cubs')

