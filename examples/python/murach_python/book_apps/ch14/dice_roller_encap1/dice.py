import random

class Die:
    def __init__(self):
        self.__value = 0

    def getValue(self):
        return self.__value
                
    def setValue(self, value):
        if value < 1 or value > 6:
            raise ValueError("Die value must be from 1 to 6.")
        else:
            self.__value = value
                
    def roll(self):
        self.__value = random.randrange(1, 7)

                
class Dice:
    def __init__(self):
        self.__list = []

    def addDie(self, die):
        self.__list.append(die)
                
    def rollAll(self):
        for die in self.__list:
            die.roll()

    # return a tuple of Die objects to prevent
    # the calling code from getting a reference to 
    # the list of Dice objects and modifying them
    def getTuple(self):
        dice_tuple = tuple(self.__list)
        return dice_tuple
