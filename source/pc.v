`timescale 1ns / 1ps

module pc
#(
    parameter WIDTH = 8
)
(
    input  wire             clk,
    input  wire             reset,
    input  wire             enable,
    input  wire             load,

    input  wire [WIDTH-1:0] load_data,

    output reg  [WIDTH-1:0] pc
);

    always @(posedge clk)
    begin
        if (reset)
        begin
            pc <= {WIDTH{1'b0}};
        end
        else if (load)
        begin
            pc <= load_data;
        end
        else if (enable)
        begin
            pc <= pc + 1'b1;
        end
    end

endmodule