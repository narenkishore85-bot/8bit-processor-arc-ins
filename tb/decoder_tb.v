`timescale 1ns / 1ps

module decoder_tb;

reg [15:0] instruction;

wire [4:0] opcode;
wire [2:0] rd;
wire [2:0] rs1;
wire [2:0] rs2;
wire [7:0] immediate;
wire [10:0] jump_addr;

decoder DUT
(
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .immediate(immediate),
    .jump_addr(jump_addr)
);

initial
begin

    instruction = 16'h5919;

    #10;

    $display("---------------------------");
    $display("Instruction = %h", instruction);
    $display("Opcode      = %b", opcode);
    $display("RD          = %d", rd);
    $display("RS1         = %d", rs1);
    $display("RS2         = %d", rs2);
    $display("Immediate   = %d", immediate);
    $display("Jump Addr   = %d", jump_addr);
    $display("---------------------------");

    $finish;

end

endmodule