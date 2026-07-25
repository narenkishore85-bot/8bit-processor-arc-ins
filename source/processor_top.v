`timescale 1ns / 1ps

module processor_top
(
    input wire clk,
    input wire reset
);

processor_core CPU
(
    .clk(clk),
    .reset(reset)
);

endmodule