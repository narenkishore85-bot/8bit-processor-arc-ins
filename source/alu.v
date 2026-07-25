`timescale 1ns / 1ps

`include "../include/alu_ops.vh"

module alu
(
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [3:0] ALU_Sel,

    output reg  [7:0] Result,
    output reg        Carry,
    output wire       Zero,
    output wire       Negative
);

always @(*)
begin

    // Default outputs
    Result = 8'h00;
    Carry  = 1'b0;

    case(ALU_Sel)

        //====================================
        // Arithmetic Operations
        //====================================

        `ALU_ADD:
            {Carry, Result} = A + B;

        `ALU_SUB:
            {Carry, Result} = A - B;

        `ALU_INC:
            {Carry, Result} = A + 8'd1;

        `ALU_DEC:
            {Carry, Result} = A - 8'd1;

        //====================================
        // Logic Operations
        //====================================

        `ALU_AND:
            Result = A & B;

        `ALU_OR:
            Result = A | B;

        `ALU_XOR:
            Result = A ^ B;

        `ALU_NOT:
            Result = ~A;

        //====================================
        // Shift Operations
        //====================================

        `ALU_SHL:
        begin
            Carry  = A[7];
            Result = A << 1;
        end

        `ALU_SHR:
        begin
            Carry  = A[0];
            Result = A >> 1;
        end

        //====================================
        // Pass Through
        //====================================

        `ALU_PASSA:
            Result = A;

        `ALU_PASSB:
            Result = B;

        //====================================
        // Compare
        //====================================

        `ALU_CMP:
        begin
            {Carry, Result} = A - B;
        end

        //====================================
        // Default
        //====================================

        default:
        begin
            Result = 8'h00;
            Carry  = 1'b0;
        end

    endcase

end

assign Zero     = (Result == 8'h00);
assign Negative = Result[7];

endmodule