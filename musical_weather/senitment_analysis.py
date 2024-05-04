import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from textblob import TextBlob
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer



# requirements: nltk
# https://textblob.readthedocs.io/en/dev/

# only need to download once
# nltk.download('all')


def get_score(phrase):
    sentiment_score = 0
    sid = SentimentIntensityAnalyzer()
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    # # get the sentiment score
    words = word_tokenize(phrase)
    words = [lemmatizer.lemmatize(word) for word in words]
    words = [word for word in words if word not in stop_words]
    sentiment_score += sid.polarity_scores(' '.join(words))['compound']
    sentiment_score += TextBlob(' '.join(words)).sentiment.polarity

    # Create a SentimentIntensityAnalyzer object.
    sid_obj = SentimentIntensityAnalyzer()
    sentiment_score += sid_obj.polarity_scores(phrase)['compound']
    
    return sentiment_score

def get_scores(phrases):
    scores = []
    for phrase in phrases:
        scores.append(get_score(phrase))
    return scores

# def main():
#     spacy_score()

# if __name__ == '__main__':
#     main()


# when getting rid of the cast or director, do you think there could be a risk of 
# actors or directors people like restrict possible movies they could like?

'''
did u consider clustering outliers to see if they are similar to each other?
'''