class Node:
    def __init__(self, symbol, freq, code=None, left = None, right = None, flag=False ):
        self.symbol = symbol
        self.freq = freq
        self.code = code
        self.left = left
        self.right = right
        self.flag = flag

    def __lt__(self, other):
        return self.freq < other.freq

def isLeaf(root):
    return root.left is None and root.right is None
