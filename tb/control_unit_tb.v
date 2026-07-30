`timescale 1ns / 1ps

`include "../include/opcodes.vh"
`include "../include/alu_ops.vh"

module control_unit_tb;

reg [4:0] opcode;

wire reg_write;
wire mem_write;
wire mem_read;

wire pc_load;
wire pc_enable;

wire flags_load;

wire [3:0] alu_sel;
wire alu_src;

control_unit DUT
(
    .opcode(opcode),

    .reg_write(reg_write),
    .mem_write(mem_write),
    .mem_read(mem_read),

    .pc_load(pc_load),
    .pc_enable(pc_enable),

    .flags_load(flags_load),

    .alu_sel(alu_sel),

    .alu_src(alu_src)
);

task show;
begin
    $display("--------------------------------------------");
    $display("Opcode     = %b", opcode);
    $display("RegWrite   = %b", reg_write);
    $display("MemRead    = %b", mem_read);
    $display("MemWrite   = %b", mem_write);
    $display("PC_Load    = %b", pc_load);
    $display("PC_Enable  = %b", pc_enable);
    $display("Flags_Load = %b", flags_load);
    $display("ALU_Sel    = %d", alu_sel);
    $display("ALU_Src    = %b", alu_src);
end
endtask

initial
begin

    $display("========== CONTROL UNIT TEST ==========");

    opcode = `OP_LDI;
    #10;
    $display("LDI");
    show();

    opcode = `OP_MOV;
    #10;
    $display("MOV");
    show();

    opcode = `OP_ADD;
    #10;
    $display("ADD");
    show();

    opcode = `OP_SUB;
    #10;
    $display("SUB");
    show();

    opcode = `OP_LOAD;
    #10;
    $display("LOAD");
    show();

    opcode = `OP_STORE;
    #10;
    $display("STORE");
    show();

    opcode = `OP_JMP;
    #10;
    $display("JMP");
    show();

    opcode = `OP_HALT;
    #10;
    $display("HALT");
    show();

    $display("=======================================");

    $finish;

end

endmodule