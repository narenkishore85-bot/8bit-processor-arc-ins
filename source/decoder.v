`timescale 1ns / 1ps

module decoder
(
    input  wire [15:0] instruction,

    output wire [4:0] opcode,
    output wire [2:0] rd,
    output wire [2:0] rs1,
    output wire [2:0] rs2,
    output wire [7:0] immediate,
    output wire [10:0] jump_addr
);

//==========================================================
// Instruction Formats
//
// R-Type
// 15        11 10      8 7      5 4      2 1      0
// +-----------+---------+---------+---------+--------+
// | OPCODE    | RD      | RS1     | RS2     | 00     |
// +-----------+---------+---------+---------+--------+
//
// I-Type
// 15        11 10      8 7                     0
// +-----------+---------+-----------------------+
// | OPCODE    | RD      | IMMEDIATE            |
// +-----------+---------+-----------------------+
//
// J-Type
// 15        11 10                         0
// +-----------+----------------------------+
// | OPCODE    | JUMP ADDRESS              |
// +-----------+----------------------------+
//
//==========================================================

assign opcode    = instruction[15:11];

assign rd        = instruction[10:8];

assign rs1       = instruction[7:5];

assign rs2       = instruction[4:2];

assign immediate = instruction[7:0];

assign jump_addr = instruction[10:0];

endmodule