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

    clk = 0;
    reset = 1;

    #20;

    reset = 0;

    #500;

    $finish;

end

endmodule