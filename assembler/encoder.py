from opcode_table import OPCODES, REGISTERS


def opcode(inst):
    return OPCODES[inst.upper()]


def reg_number(reg):
    return REGISTERS[reg.upper()]


# ==========================================
# Arithmetic
# ==========================================

def encode_add(rd, rs1, rs2):

    op = opcode("ADD")

    rd = reg_number(rd)
    rs1 = reg_number(rs1)
    rs2 = reg_number(rs2)

    return (op << 11) | (rd << 8) | (rs1 << 5) | (rs2 << 2)


def encode_sub(rd, rs1, rs2):

    op = opcode("SUB")

    rd = reg_number(rd)
    rs1 = reg_number(rs1)
    rs2 = reg_number(rs2)

    return (op << 11) | (rd << 8) | (rs1 << 5) | (rs2 << 2)


# ==========================================
# Logic
# ==========================================

def encode_and(rd, rs1, rs2):

    op = opcode("AND")

    rd = reg_number(rd)
    rs1 = reg_number(rs1)
    rs2 = reg_number(rs2)

    return (op << 11) | (rd << 8) | (rs1 << 5) | (rs2 << 2)


def encode_or(rd, rs1, rs2):

    op = opcode("OR")

    rd = reg_number(rd)
    rs1 = reg_number(rs1)
    rs2 = reg_number(rs2)

    return (op << 11) | (rd << 8) | (rs1 << 5) | (rs2 << 2)


def encode_xor(rd, rs1, rs2):

    op = opcode("XOR")

    rd = reg_number(rd)
    rs1 = reg_number(rs1)
    rs2 = reg_number(rs2)

    return (op << 11) | (rd << 8) | (rs1 << 5) | (rs2 << 2)


def encode_not(rd, rs):

    op = opcode("NOT")

    rd = reg_number(rd)
    rs = reg_number(rs)

    return (op << 11) | (rd << 8) | (rs << 5)


# ==========================================
# Shift
# ==========================================

def encode_shl(rd, rs):

    op = opcode("SHL")

    rd = reg_number(rd)
    rs = reg_number(rs)

    return (op << 11) | (rd << 8) | (rs << 5)


def encode_shr(rd, rs):

    op = opcode("SHR")

    rd = reg_number(rd)
    rs = reg_number(rs)

    return (op << 11) | (rd << 8) | (rs << 5)


# ==========================================
# Memory
# ==========================================

def encode_load(rd, addr):

    op = opcode("LOAD")

    rd = reg_number(rd)

    return (op << 11) | (rd << 8) | addr


def encode_store(rs, addr):

    op = opcode("STORE")

    rs = reg_number(rs)

    return (op << 11) | (rs << 8) | addr


def encode_loadi(rd, imm):

    op = opcode("LOADI")

    rd = reg_number(rd)

    return (op << 11) | (rd << 8) | imm


# ==========================================
# Compare
# ==========================================

def encode_cmp(rs1, rs2):

    op = opcode("CMP")

    rs1 = reg_number(rs1)
    rs2 = reg_number(rs2)

    return (op << 11) | (rs1 << 5) | (rs2 << 2)


# ==========================================
# Branch
# ==========================================

def encode_jmp(addr):
    return (opcode("JMP") << 11) | addr


def encode_jz(addr):
    return (opcode("JZ") << 11) | addr


def encode_jnz(addr):
    return (opcode("JNZ") << 11) | addr


def encode_jc(addr):
    return (opcode("JC") << 11) | addr


def encode_jnc(addr):
    return (opcode("JNC") << 11) | addr

def encode_beq(addr):

    op = opcode("BEQ")

    return (op << 11) | addr


def encode_bne(addr):

    op = opcode("BNE")

    return (op << 11) | addr


def encode_bc(addr):

    op = opcode("BC")

    return (op << 11) | addr


def encode_bn(addr):

    op = opcode("BN")

    return (op << 11) | addr

def encode_mov(rd, rs):

    op = opcode("MOV")

    rd = reg_number(rd)
    rs = reg_number(rs)

    return (op << 11) | (rd << 8) | (rs << 5)

# ==========================================
# Misc
# ==========================================

def encode_halt():
    return opcode("HALT") << 11


def encode_nop():
    return opcode("NOP") << 11

