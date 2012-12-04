# scrapes in data from twitter about the CTA 

# search fior tweets that include cta twitter handle
require(twitteR)
cta.handle.tweets <- searchTwitter('@cta', n=1500)
save(cta.handle.tweets, file=file.path("./data", 'cta.handle.RData' ), ascii=T)

# search using hash tag
cta.hash.tweets <- searchTwitter('#cta', n=1500)
save(cta.hash.tweets, file=file.path("./data", 'cta.hash.RData' ), ascii=T)


