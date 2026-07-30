`timescale 1ns / 1ps

`include "../include/alu_ops.vh"

module alu_tb;

reg  [7:0] A;
reg  [7:0] B;
reg  [3:0] ALU_Sel;

wire [7:0] Result;
wire Carry;
wire Zero;
wire Negative;

alu DUT
(
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .Result(Result),
    .Carry(Carry),
    .Zero(Zero),
    .Negative(Negative)
);

initial
begin

    $display("======================================");
    $display("        ALU TEST STARTED");
    $display("======================================");

    // ADD
    A = 25;
    B = 10;
    ALU_Sel = `ALU_ADD;
    #10;
    $display("ADD    : %d + %d = %d", A, B, Result);

    // SUB
    ALU_Sel = `ALU_SUB;
    #10;
    $display("SUB    : %d - %d = %d", A, B, Result);

    // AND
    A = 8'hAA;
    B = 8'h55;
    ALU_Sel = `ALU_AND;
    #10;
    $display("AND    : %h", Result);

    // OR
    ALU_Sel = `ALU_OR;
    #10;
    $display("OR     : %h", Result);

    // XOR
    ALU_Sel = `ALU_XOR;
    #10;
    $display("XOR    : %h", Result);

    // NOT
    A = 8'h0F;
    ALU_Sel = `ALU_NOT;
    #10;
    $display("NOT    : %h", Result);

    // SHL
    A = 8'b10010001;
    ALU_Sel = `ALU_SHL;
    #10;
    $display("SHL    : %b Carry=%b", Result, Carry);

    // SHR
    A = 8'b10010001;
    ALU_Sel = `ALU_SHR;
    #10;
    $display("SHR    : %b Carry=%b", Result, Carry);

    // PASS A
    A = 8'd99;
    ALU_Sel = `ALU_PASSA;
    #10;
    $display("PASS A : %d", Result);

    // PASS B
    B = 8'd42;
    ALU_Sel = `ALU_PASSB;
    #10;
    $display("PASS B : %d", Result);

    // CMP
    A = 25;
    B = 25;
    ALU_Sel = `ALU_CMP;
    #10;
    $display("CMP    : Result=%d Zero=%b", Result, Zero);

    $display("======================================");
    $display("        ALU TEST FINISHED");
    $display("======================================");

    $finish;

end

endmodule