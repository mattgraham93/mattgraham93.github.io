import random

class Die:
    def __init__(self):
        self.value = 0
                
    def roll(self):
        self.value = random.randrange(1, 7)

                
class Dice:
    def __init__(self):
        self.list = []

    def addDie(self, die):
        self.list.append(die)
                
    def rollAll(self):
        for die in self.list:
            die.roll()
