`timescale 1ns / 1ps

module processor_tb;

reg clk;
reg reset;

processor_top DUT
(
    .clk(clk),
    .reset(reset)
);

// Clock Generation
always #5 clk = ~clk;

// Test Sequence
initial

begin
    $dumpfile("output/mnx8.vcd");
    $dumpvars(0, processor_tb);

    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #100;

    $display("--------------------------------------");
    $display("PC          = %d", DUT.CPU.pc);
    $display("Instruction = %h", DUT.CPU.instruction);
    $display("Opcode      = %b", DUT.CPU.opcode);
    $display("Immediate   = %d", DUT.CPU.immediate);

    $display("R0 = %d", DUT.CPU.REGFILE.registers[0]);
    $display("R1 = %d", DUT.CPU.REGFILE.registers[1]);
    $display("R2 = %d", DUT.CPU.REGFILE.registers[2]);
    $display("R3 = %d", DUT.CPU.REGFILE.registers[3]);

    $display("--------------------------------------");

    $finish;
end

endmodule