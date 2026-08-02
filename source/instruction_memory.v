`timescale 1ns / 1ps

module instruction_memory
#(
    parameter MEM_DEPTH = 256,
    parameter MEM_FILE  = "mem/program.mem"
)
(
    input  wire        clk,
    input  wire [7:0]  address,
    output reg  [15:0] instruction
);

    //========================================================
    // Instruction Memory
    //========================================================

    reg [15:0] memory [0:MEM_DEPTH-1];

    integer i;

    //========================================================
    // Initialize Memory
    //========================================================

    initial
    begin

        // Clear memory

        for(i = 0; i < MEM_DEPTH; i = i + 1)
            memory[i] = 16'h0000;

        // Load program if available

        $readmemh(MEM_FILE, memory);

    end

    //========================================================
    // Instruction Fetch
    //========================================================

    always @(*)
    begin
        instruction = memory[address];
    end

endmodule