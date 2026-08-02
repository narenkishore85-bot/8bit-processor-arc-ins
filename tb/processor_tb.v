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
//======================================================
// CPU Monitor
//======================================================

always @(posedge clk)
begin
    if(!reset)
    begin
        $display("--------------------------------");
        $display("PC        = %0d", DUT.CPU.pc);
        $display("INST      = %h", DUT.CPU.instruction);
        $display("OPCODE    = %b", DUT.CPU.opcode);
        $display("IMM       = %0d", DUT.CPU.immediate);

        $display("MemRead   = %b", DUT.CPU.mem_read);
        $display("MemWrite  = %b", DUT.CPU.mem_write);
        $display("RegWrite  = %b", DUT.CPU.reg_write);

        $display("Address   = %0d", DUT.CPU.immediate);
        $display("MemData   = %0d", DUT.CPU.mem_data);
        $display("WB Data   = %0d", DUT.CPU.write_back_data);

        $display("R1=%0d R2=%0d R3=%0d",
            DUT.CPU.REGFILE.registers[1],
            DUT.CPU.REGFILE.registers[2],
            DUT.CPU.REGFILE.registers[3]);

        $display("Carry=%b Zero=%b Negative=%b",
            DUT.CPU.carry,
            DUT.CPU.zero,
            DUT.CPU.negative);
        $display("WB Data   = %0d", DUT.CPU.write_back_data);
        $display("Overflow=%b", DUT.CPU.overflow);
        $display("Carry=%b Zero=%b Negative=%b Overflow=%b",
         DUT.CPU.carry,
         DUT.CPU.zero,
         DUT.CPU.negative,
         DUT.CPU.overflow);
    end
end

initial
begin
    $dumpfile("output/mnx8.vcd");
    $dumpvars(0, processor_tb);

    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #80;

    $finish;
end

endmodule