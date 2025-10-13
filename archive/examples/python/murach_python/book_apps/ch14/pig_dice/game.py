from dice import Die

class Game:
    def __init__(self):
        self.turn = 1
        self.score = 0
        self.scoreThisTurn = 0
        self.isTurnOver = False
        self.isGameOver = False
        self.die = Die()
