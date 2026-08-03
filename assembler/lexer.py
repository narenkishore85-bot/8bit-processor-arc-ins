# ==========================================
# MNX-8 Lexer
# ==========================================

def tokenize(line):

    # Remove comments
    if ";" in line:
        line = line[:line.index(";")]

    line = line.strip()

    if line == "":
        return []

    # Replace commas with spaces
    line = line.replace(",", " ")

    # Split into tokens
    tokens = line.split()

    return tokens