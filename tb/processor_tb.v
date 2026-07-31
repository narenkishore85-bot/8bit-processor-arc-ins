`timescale 1ns / 1ps

module processor_tb;

reg clk;
reg reset;

processor_top DUT
(
    .clk(clk),
    .reset(reset)
);

//--------------------------------------------------
// Clock Generation
//--------------------------------------------------

always #5 clk = ~clk;

//--------------------------------------------------
// Test Sequence
//--------------------------------------------------

initial
begin

    $dumpfile("output/mnx8.vcd");
    $dumpvars(0, processor_tb);

    clk   = 0;
    reset = 1;

    // Hold reset
    #20;
    reset = 0;

    // Run CPU for a few instructions
    #40;

    $display("--------------------------------------");
    $display("PC          = %d", DUT.CPU.pc);
    $display("Instruction = %h", DUT.CPU.instruction);
    $display("Opcode      = %b", DUT.CPU.opcode);
    $display("Immediate   = %d", DUT.CPU.immediate);

    $display("--------------------------------------");

    $display("R0 = %d", DUT.CPU.REGFILE.registers[0]);
    $display("R1 = %d", DUT.CPU.REGFILE.registers[1]);
    $display("R2 = %d", DUT.CPU.REGFILE.registers[2]);
    $display("R3 = %d", DUT.CPU.REGFILE.registers[3]);

    $display("--------------------------------------");

    $display("RegWrite    = %b", DUT.CPU.reg_write);
    $display("MemRead     = %b", DUT.CPU.mem_read);
    $display("MemWrite    = %b", DUT.CPU.mem_write);

    $display("ALU_Sel     = %d", DUT.CPU.alu_sel);

    $display("ALU Input A = %d", DUT.CPU.reg_data1);
    $display("ALU Input B = %d", DUT.CPU.reg_data2);

    $display("ALU Result  = %d", DUT.CPU.alu_result);

    $display("--------------------------------------");

    $display("--------------------------------------");
$display("Carry Flag    = %b", DUT.CPU.carry);
$display("Zero Flag     = %b", DUT.CPU.zero);
$display("Negative Flag = %b", DUT.CPU.negative);

    $finish;

end

endmodule