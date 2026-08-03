# ==========================================
# MNX-8 Parser
# ==========================================

def parse(tokens):

    if len(tokens) == 0:
        return None

    inst = tokens[0].upper()

    operands = tokens[1:]

    return inst, operands