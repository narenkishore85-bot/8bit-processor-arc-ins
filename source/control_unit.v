`timescale 1ns / 1ps

`include "../include/opcodes.vh"
`include "../include/alu_ops.vh"

module control_unit
(
    input  wire [4:0] opcode,

    output reg        reg_write,
    output reg        mem_write,
    output reg        mem_read,

    output reg        pc_load,
    output reg        pc_enable,

    output reg        flags_load,

    output reg [3:0]  alu_sel,

    output reg        alu_src
);

always @(*)
begin

    //--------------------------------------------------
    // Default Values
    //--------------------------------------------------

    reg_write  = 1'b0;
    mem_write  = 1'b0;
    mem_read   = 1'b0;

    pc_load    = 1'b0;
    pc_enable  = 1'b1;

    flags_load = 1'b0;

    alu_sel    = `ALU_ADD;
    alu_src    = 1'b0;

    //--------------------------------------------------
    // Instruction Decode
    //--------------------------------------------------

    case(opcode)

        //------------------------------------------
        // No Operation
        //------------------------------------------

        `OP_NOP:
        begin
        end

        //------------------------------------------
        // Arithmetic
        //------------------------------------------

        `OP_ADD:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_ADD;
        end

        `OP_SUB:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_SUB;
        end

        //------------------------------------------
        // Logic
        //------------------------------------------

        `OP_AND:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_AND;
        end

        `OP_OR:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_OR;
        end

        `OP_XOR:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_XOR;
        end

        `OP_NOT:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_NOT;
        end

        //------------------------------------------
        // Shift
        //------------------------------------------

        `OP_SHL:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_SHL;
        end

        `OP_SHR:
        begin
            reg_write  = 1'b1;
            flags_load = 1'b1;
            alu_sel    = `ALU_SHR;
        end

        //------------------------------------------
        // Load Immediate
        //------------------------------------------

        `OP_LDI:
        begin
            reg_write = 1'b1;
            alu_src   = 1'b1;
            alu_sel   = `ALU_PASSB;
        end

        //------------------------------------------
        // Memory Load
        //------------------------------------------

        `OP_LOAD:
        begin
            mem_read  = 1'b1;
            reg_write = 1'b1;
            alu_sel   = `ALU_ADD;
        end

        //------------------------------------------
        // Memory Store
        //------------------------------------------

        `OP_STORE:
        begin
            mem_write = 1'b1;
            alu_sel   = `ALU_ADD;
        end

        //------------------------------------------
        // Compare
        //------------------------------------------

        `OP_CMP:
        begin
            flags_load = 1'b1;
            alu_sel    = `ALU_CMP;
        end

        //------------------------------------------
        // Move Register
        //------------------------------------------

        `OP_MOV:
        begin
            reg_write = 1'b1;
            alu_sel   = `ALU_PASSA;
        end

        //------------------------------------------
        // Jump
        //------------------------------------------

        `OP_JMP:
        begin
            pc_load   = 1'b1;
            pc_enable = 1'b0;
        end

        //------------------------------------------
        // Branches
        //------------------------------------------

        `OP_BEQ:
        begin
            // Implement with flags in next version
        end

        `OP_BNE:
        begin
        end

        `OP_BC:
        begin
        end

        `OP_BN:
        begin
        end

        //------------------------------------------
        // Halt
        //------------------------------------------

        `OP_HALT:
        begin
            pc_enable = 1'b0;
        end

        //------------------------------------------
        // Unknown Opcode
        //------------------------------------------

        default:
        begin
        end

    endcase

end

endmodule