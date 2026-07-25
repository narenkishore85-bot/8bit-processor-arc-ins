`timescale 1ns / 1ps

module register_file
#(
    parameter DATA_WIDTH = 8,
    parameter REG_COUNT  = 8
)
(
    input  wire                     clk,
    input  wire                     reset,
    input  wire                     write_enable,

    input  wire [2:0]               read_addr1,
    input  wire [2:0]               read_addr2,
    input  wire [2:0]               write_addr,

    input  wire [DATA_WIDTH-1:0]    write_data,

    output wire [DATA_WIDTH-1:0]    read_data1,
    output wire [DATA_WIDTH-1:0]    read_data2
);

    //========================================================
    // Register Array
    //========================================================

    reg [DATA_WIDTH-1:0] registers [0:REG_COUNT-1];

    integer i;

    //========================================================
    // Reset and Write
    //========================================================

    always @(posedge clk)
    begin
        if (reset)
        begin
            for(i = 0; i < REG_COUNT; i = i + 1)
                registers[i] <= {DATA_WIDTH{1'b0}};
        end
        else if(write_enable)
        begin
            registers[write_addr] <= write_data;
        end
    end

    //========================================================
    // Read Ports
    //========================================================

    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];

endmodule