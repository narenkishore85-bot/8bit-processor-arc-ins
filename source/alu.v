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

    // Default outputs
    Result   = 8'h00;
    Carry    = 1'b0;
    Overflow = 1'b0;
    temp     = 9'd0;

    case (ALU_Sel)

        //========================================
        // ADD
        //========================================
        `ALU_ADD:
        begin
            temp   = {1'b0,A} + {1'b0,B};

            Result = temp[7:0];
            Carry  = temp[8];

            Overflow =
                (~A[7] & ~B[7] & Result[7]) |
                ( A[7] &  B[7] & ~Result[7]);
        end

        //========================================
        // SUB
        //========================================
        `ALU_SUB:
        begin
            temp   = {1'b0,A} - {1'b0,B};

            Result = temp[7:0];
            Carry  = (A >= B);

            Overflow =
                ( A[7] & ~B[7] & ~Result[7]) |
                (~A[7] &  B[7] &  Result[7]);
        end

        //========================================
        // INC
        //========================================
        `ALU_INC:
        begin
            temp   = {1'b0,A} + 9'd1;

            Result = temp[7:0];
            Carry  = temp[8];
        end

        //========================================
        // DEC
        //========================================
        `ALU_DEC:
        begin
            temp   = {1'b0,A} - 9'd1;

            Result = temp[7:0];
            Carry  = (A != 8'd0);
        end

        //========================================
        // AND
        //========================================
        `ALU_AND:
        begin
            Result = A & B;
        end

        //========================================
        // OR
        //========================================
        `ALU_OR:
        begin
            Result = A | B;
        end

        //========================================
        // XOR
        //========================================
        `ALU_XOR:
        begin
            Result = A ^ B;
        end

        //========================================
        // NOT
        //========================================
        `ALU_NOT:
        begin
            Result = ~A;
        end

        //========================================
        // Shift Left
        //========================================
        `ALU_SHL:
        begin
            Carry  = A[7];
            Result = A << 1;
        end

        //========================================
        // Shift Right
        //========================================
        `ALU_SHR:
        begin
            Carry  = A[0];
            Result = A >> 1;
        end

        //========================================
        // PASS A
        //========================================
        `ALU_PASSA:
        begin
            Result = A;
        end

        //========================================
        // PASS B
        //========================================
        `ALU_PASSB:
        begin
            Result = B;
        end

        //========================================
        // COMPARE
        //========================================
        `ALU_CMP:
        begin
            temp   = {1'b0,A} - {1'b0,B};

            Result = temp[7:0];
            Carry  = (A >= B);

            Overflow =
                ( A[7] & ~B[7] & ~Result[7]) |
                (~A[7] &  B[7] &  Result[7]);
        end

        //========================================
        // Default
        //========================================
        default:
        begin
            Result   = 8'h00;
            Carry    = 1'b0;
            Overflow = 1'b0;
        end

    endcase

end

assign Zero     = (Result == 8'h00);
assign Negative = Result[7];

endmodule