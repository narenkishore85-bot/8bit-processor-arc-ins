`timescale 1ns / 1ps

`include "../include/opcodes.vh"

module processor_tb;

reg clk;
reg reset;

//==================================================
// DUT
//==================================================

processor_top DUT
(
    .clk(clk),
    .reset(reset)
);

//==================================================
// Clock
//==================================================

initial
    clk = 0;

always
    #5 clk = ~clk;

//==================================================
// Reset
//==================================================

initial
begin
    reset = 1;
    #20;
    reset = 0;
end

//==================================================
// Header
//==================================================

initial
begin
    $display("");
    $display("==============================================");
    $display("        MNX-8 RISC Processor Simulation");
    $display("==============================================");
    $display("");
    $display("Cycle PC  INST   OP    R1  R2  R3  ALU  WB  C Z N V");
    $display("--------------------------------------------------------------");
end

//==================================================
// Cycle Counter
//==================================================

integer cycle;

always @(posedge clk)
begin

    if(reset)
        cycle <= 0;
    else
        cycle <= cycle + 1;

end

//==================================================
// CPU Monitor
//==================================================

always @(posedge clk)
begin

    if(!reset)
    begin

        $display("%2d    %2d  %h  %02h   %3d %3d %3d %3d %3d  %b %b %b %b",

            cycle,

            DUT.CPU.pc,
            DUT.CPU.instruction,

            DUT.CPU.opcode,

            DUT.CPU.REGFILE.registers[1],
            DUT.CPU.REGFILE.registers[2],
            DUT.CPU.REGFILE.registers[3],

            DUT.CPU.alu_result,
            DUT.CPU.write_back_data,

            DUT.CPU.carry,
            DUT.CPU.zero,
            DUT.CPU.negative,
            DUT.CPU.overflow
        );

    end

end

//==================================================
// Stop at HALT
//==================================================

always @(posedge clk)
begin

    if(!reset)
    begin

        if(DUT.CPU.opcode == `OP_HALT)
        begin

            $display("");
            $display("");
            $display("==============================================");
            $display("Program Finished");
            $display("==============================================");

            $display("");

            $display("Final Register Values");

            $display("----------------------");

            $display("R0 = %0d", DUT.CPU.REGFILE.registers[0]);
            $display("R1 = %0d", DUT.CPU.REGFILE.registers[1]);
            $display("R2 = %0d", DUT.CPU.REGFILE.registers[2]);
            $display("R3 = %0d", DUT.CPU.REGFILE.registers[3]);
            $display("R4 = %0d", DUT.CPU.REGFILE.registers[4]);
            $display("R5 = %0d", DUT.CPU.REGFILE.registers[5]);
            $display("R6 = %0d", DUT.CPU.REGFILE.registers[6]);
            $display("R7 = %0d", DUT.CPU.REGFILE.registers[7]);

            $display("");

            $display("Flags");

            $display("----------------------");

            $display("Carry    = %b", DUT.CPU.carry);
            $display("Zero     = %b", DUT.CPU.zero);
            $display("Negative = %b", DUT.CPU.negative);
            $display("Overflow = %b", DUT.CPU.overflow);

            $display("");

            $finish;

        end

    end

end

//==================================================
// Waveform
//==================================================

initial
begin

    $dumpfile("output/mnx8.vcd");
    $dumpvars(0, processor_tb);

end

endmodule