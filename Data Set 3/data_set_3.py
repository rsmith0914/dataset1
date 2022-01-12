---
Title: 'Twitter Scraper'
Author: 'Ryan'
Date: '3/13/21'
---

#import packages
import tweepy
from wordcloud import WordCloud
import matplotlib.pyplot as plt
%matplotlib inline

#API integration
consumer_key = "pjrQHV91v8botBHsDO4ETQVha"
consumer_secret = "8DDJkhPi4AyQXsDNFu2VAAmjzWUn70DgSYAvUXntOgeSUD6dCM"
access_token = "1000696034-wKw3owykAuRcopDXXInxvlrHxN7IUSDYpPWiBFd"
access_token_secret = "CGzJIfV3New3l7BUtRfBgzrRAe95DGyLrE68AEitq9Bzi"
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth,wait_on_rate_limit=True)

#cleaning up search
def tweetSearch(query, limit = 500, language = "en", remove = []):
    text = ""
    for tweet in tweepy.Cursor(api.search, q=query, lang=language).items(limit):
        text += tweet.text.lower()
    removeWords = ["https","co"]
    removeWords += remove
    for word in removeWords:
        text = text.replace(word, "")
    return text

#search term
search = tweetSearch(“covid vaccine”)
wordcloud = WordCloud().generate(search)

#create wordcloud
plt.figure(figsize=(14,8))
plt.imshow(wordcloud, interpolation=’bilinear’)
plt.axis(“off”)
plt.show()search = tweetSearch(“datascience”)
