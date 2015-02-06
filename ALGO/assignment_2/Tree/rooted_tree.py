class Tree:
    def __init__(self, w, s=[]):
        self.weight = w
        self.sons = s

    def size(self):
        return 1 + sum([s.size() for s in self.sons] or [0])

if __name__ == "__main__":
    pass