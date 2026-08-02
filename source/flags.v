`timescale 1ns / 1ps

module flags
(
    input  wire       clk,
    input  wire       reset,
    input  wire       load,

    input  wire       carry_in,
    input  wire       zero_in,
    input  wire       negative_in,
    input wire overflow_in,

    output reg        carry,
    output reg        zero,
    output reg        negative,
    output reg overflow
);

always @(posedge clk)
begin

    if(reset)
    begin
        carry    <= 1'b0;
        zero     <= 1'b0;
        negative <= 1'b0;
        overflow  <= 1'b0;
    end

    else if(load)
    begin
        carry    <= carry_in;
        zero     <= zero_in;
        negative <= negative_in;
        overflow  <= overflow_in;
    end

end

endmodule