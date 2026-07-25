`timescale 1ns / 1ps

module data_memory
#(
    parameter MEM_DEPTH = 256
)
(
    input  wire        clk,
    input  wire        we,          // Write Enable
    input  wire [7:0]  address,
    input  wire [7:0]  write_data,
    output wire [7:0]  read_data
);

    //========================================================
    // Data Memory
    //========================================================

    reg [7:0] memory [0:MEM_DEPTH-1];

    integer i;

    //========================================================
    // Initialize Memory
    //========================================================

    initial
    begin
        for(i = 0; i < MEM_DEPTH; i = i + 1)
            memory[i] = 8'h00;
    end

    //========================================================
    // Synchronous Write
    //========================================================

    always @(posedge clk)
    begin
        if (we)
            memory[address] <= write_data;
    end

    //========================================================
    // Asynchronous Read
    //========================================================

    assign read_data = memory[address];

endmodule