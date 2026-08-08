from encoder import *
from lexer import tokenize
from parser import parse



# ==========================================
# Symbol Table
# ==========================================

symbols = {}


# ==========================================
# Assemble One Instruction
# ==========================================

def assemble_line(line):

    global symbols

    line = line.strip()

    if line == "":
        return None

    if line.startswith(";"):
        return None

    tokens = tokenize(line)

    if len(tokens) == 0:
        return None

    parsed = parse(tokens)

    if parsed is None:
        return None

    inst, operands = parsed

    # ======================================
    # Arithmetic
    # ======================================

    if inst == "ADD":
        return encode_add(operands[0], operands[1], operands[2])

    elif inst == "SUB":
        return encode_sub(operands[0], operands[1], operands[2])

    # ======================================
    # Logic
    # ======================================

    elif inst == "AND":
        return encode_and(operands[0], operands[1], operands[2])

    elif inst == "OR":
        return encode_or(operands[0], operands[1], operands[2])

    elif inst == "XOR":
        return encode_xor(operands[0], operands[1], operands[2])

    elif inst == "NOT":
        return encode_not(operands[0], operands[1])

    # ======================================
    # Shift
    # ======================================

    elif inst == "SHL":
        return encode_shl(operands[0], operands[1])

    elif inst == "SHR":
        return encode_shr(operands[0], operands[1])

    # ======================================
    # Memory
    # ======================================

    elif inst == "LOAD":
        return encode_load(operands[0], int(operands[1]))

    elif inst == "STORE":
        return encode_store(operands[0], int(operands[1]))

    elif inst == "LOADI":
        return encode_loadi(operands[0], int(operands[1]))

    # ======================================
    # Compare
    # ======================================

    elif inst == "CMP":
        return encode_cmp(operands[0], operands[1])
    
        # ======================================
    # Branch Instructions
    # ======================================

    elif inst == "JMP":

        target = operands[0]

        if target.isdigit():
            addr = int(target)
        else:
            addr = symbols[target]

        return encode_jmp(addr)

    elif inst == "JZ":

        target = operands[0]

        if target.isdigit():
            addr = int(target)
        else:
            addr = symbols[target]

        return encode_jz(addr)

    elif inst == "JNZ":

        target = operands[0]

        if target.isdigit():
            addr = int(target)
        else:
            addr = symbols[target]

        return encode_jnz(addr)

    elif inst == "JC":

        target = operands[0]

        if target.isdigit():
            addr = int(target)
        else:
            addr = symbols[target]

        return encode_jc(addr)

    elif inst == "JNC":

        target = operands[0]

        if target.isdigit():
            addr = int(target)
        else:
            addr = symbols[target]

        return encode_jnc(addr)

    # ======================================
    # Misc
    # ======================================

    elif inst == "NOP":
        return encode_nop()

    elif inst == "HALT":
        return encode_halt()
    
    elif inst == "BEQ":
        return encode_beq(int(operands[0]))

    elif inst == "BNE":
        return encode_bne(int(operands[0]))

    elif inst == "BC":
        return encode_bc(int(operands[0]))

    elif inst == "BN":
        return encode_bn(int(operands[0]))
    
    elif inst == "MOV":
        return encode_mov(operands[0], operands[1])

    else:
        raise ValueError(f"Unknown instruction: {inst}")


# ==========================================
# Read Source File
# ==========================================

with open("sample.asm", "r") as f:
    lines = f.readlines()


# ==========================================
# Pass 1 : Build Symbol Table
# ==========================================

symbols = {}

pc = 0

for line in lines:

    line = line.strip()

    if line == "":
        continue

    if line.startswith(";"):
        continue

    if line.endswith(":"):
        label = line[:-1]
        symbols[label] = pc
    else:
        pc += 1

# ==========================================
# Pass 2 : Generate Machine Code
# ==========================================

machine = []

for line in lines:

    line = line.strip()

    if line == "":
        continue

    if line.startswith(";"):
        continue

    # Skip labels
    if line.endswith(":"):
        continue

    code = assemble_line(line)

    if code is not None:
        machine.append(code)


# ==========================================
# Write program.mem
# ==========================================

with open("../mem/program.mem", "w") as f:

    for inst in machine:
        f.write(f"{inst:04X}\n")


# ==========================================
# Print Result
# ==========================================

print("\n====================================")
print("MNX-8 Assembler")
print("====================================")

print("\nMachine Code:")

for inst in machine:
    print(f"{inst:04X}")

print("\nLabels:")

if len(symbols) == 0:
    print("(none)")
else:
    for label, addr in symbols.items():
        print(f"{label:10} -> {addr}")

print("\nAssembly complete!")