import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer

# only need to download once
# nltk.download('all')

def get_score(phrase):
    sentiment_score = 0
    sid = SentimentIntensityAnalyzer()
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    # get the sentiment score
    words = word_tokenize(phrase)
    words = [lemmatizer.lemmatize(word) for word in words]
    words = [word for word in words if word not in stop_words]
    sentiment_score += sid.polarity_scores(' '.join(words))['compound']
    return sentiment_score

def get_scores(phrases):
    scores = []
    for phrase in phrases:
        scores.append(get_score(phrase))
    return scores