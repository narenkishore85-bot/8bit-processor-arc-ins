`timescale 1ns / 1ps

`include "../include/alu_ops.vh"

module alu
(
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [3:0] ALU_Sel,

    output reg  [7:0] Result,
    output reg        Carry,
    output reg        Overflow,
    output wire       Zero,
    output wire       Negative
);

reg [8:0] temp;
always @(*)
begin

    Result   = 8'h00;
    Carry    = 1'b0;
    Overflow = 1'b0;
    temp      = 9'h000;

    case(ALU_Sel)

        //====================================
        // Arithmetic Operations
        //====================================
    `ALU_ADD:
    begin
        temp   = {1'b0, A} + {1'b0, B};
        Result = temp[7:0];
        Carry  = temp[8];
    end

    `ALU_SUB:
    begin
        temp   = {1'b0, A} - {1'b0, B};
        Result = temp[7:0];
        Carry = (A >= B);      // Carry = No Borrow
    end

    `ALU_INC:
    begin
        temp   = {1'b0, A} + 9'd1;
        Result = temp[7:0];
        Carry  = temp[8];
    end

    `ALU_DEC:
    begin
        temp   = {1'b0, A} - 9'd1;
        Result = temp[7:0];
        Carry  = ~temp[8];
    end

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
            temp   = {1'b0,A} - {1'b0,B};

            Result = temp[7:0];
            Carry  = (A >= B);

            Overflow =
                ( A[7] & ~B[7] & ~Result[7]) |
                (~A[7] &  B[7] &  Result[7]);
        end


        `ALU_ADD:
        begin
            temp   = {1'b0,A} + {1'b0,B};

            Result = temp[7:0];
            Carry  = temp[8];

            Overflow =
                (~A[7] & ~B[7] & Result[7]) |
                ( A[7] &  B[7] & ~Result[7]);
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