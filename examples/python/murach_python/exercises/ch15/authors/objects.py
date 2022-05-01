class Book:
    def __init__(self, title="", authors=None):
        self.title = title
        self.authors = authors

    def getDescription(self):
        return self.title + " by " + self.authors
                
class Author:
    def __init__(self, firstName="", lastName=""):
        self.firstName = firstName
        self.lastName = lastName

class Authors:
    def __init__(self):
        self.__list = []

    def add(self, author):
        self.__list.append(author)

    @property
    def count(self):
        return len(self.__list)
