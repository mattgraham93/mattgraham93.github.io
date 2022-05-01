import random

class Die:
    def __init__(self):
        self.__value = 0

    @property
    def value(self):
        return self.__value
                
    @value.setter
    def value(self, value):
        if value < 1:
            raise ValueError("Die can't be less than 1.")
        else:
            self.__value = value
                
    def roll(self):
        self.__value = random.randrange(1, 7)

                
class Dice:
    def __init__(self):
        self.__list = []

    def addDie(self, die):
        self.__list.append(die)

    @property
    def list(self):
        dice_tuple = tuple(self.__list)
        return dice_tuple
                
    def rollAll(self):
        for die in self.__list:
            die.roll()
