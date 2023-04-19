class Node:
    def __init__(self, symbol, freq, code=None, left = None, right = None):
        self.symbol = symbol
        self.freq = freq
        self.code = code
        self.left = left
        self.right = right

    def __lt__(self, other):
        return self.freq < other.freq

def isLeaf(root):
    return root.left is None and root.right is None
    