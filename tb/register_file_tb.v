`timescale 1ns / 1ps

module register_file_tb;

reg clk;
reg reset;
reg write_enable;

reg [2:0] read_addr1;
reg [2:0] read_addr2;
reg [2:0] write_addr;

reg [7:0] write_data;

wire [7:0] read_data1;
wire [7:0] read_data2;

register_file DUT
(
    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),

    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),

    .write_data(write_data),

    .read_data1(read_data1),
    .read_data2(read_data2)
);

always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;
    write_enable = 0;

    read_addr1 = 0;
    read_addr2 = 0;
    write_addr = 0;
    write_data = 0;

    #10;
    reset = 0;

    // Write 25 to R1
    write_enable = 1;
    write_addr = 3'd1;
    write_data = 8'd25;

    #10;

    // Stop writing
    write_enable = 0;

    // Read R1
    read_addr1 = 3'd1;

    #10;

    $display("----------------------");
    $display("Register File Test");
    $display("R1 = %d", read_data1);

    if(read_data1 == 8'd25)
        $display("PASS");
    else
        $display("FAIL");

    $display("----------------------");

    $finish;

end

endmodule