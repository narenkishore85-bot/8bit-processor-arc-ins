`timescale 1ns / 1ps

module processor_core
(
    input wire clk,
    input wire reset
);

    //========================================================
    // Program Counter
    //========================================================

    wire [7:0] pc;

    //========================================================
    // Instruction
    //========================================================

    wire [15:0] instruction;

    //========================================================
    // Decoder Outputs
    //========================================================

    wire [4:0] opcode;
    wire [2:0] rd;
    wire [2:0] rs1;
    wire [2:0] rs2;
    wire [7:0] immediate;

    //========================================================
    // Register File
    //========================================================

    wire [7:0] reg_data1;
    wire [7:0] reg_data2;
    wire [7:0] write_back_data;

    //========================================================
    // ALU
    //========================================================

    wire [7:0] alu_result;
    wire       carry_flag;
    wire       zero_flag;
    wire       negative_flag;

    //========================================================
    // Data Memory
    //========================================================

    wire [7:0] mem_data;

    //========================================================
    // Control Signals
    //========================================================

    wire reg_write;
    wire mem_write;
    wire mem_read;

    wire pc_load;
    wire pc_enable;

    wire flags_load;

    wire alu_src;

    wire [3:0] alu_sel;
    //========================================================
    // Program Counter
    //========================================================

    pc PC
    (
        .clk(clk),
        .reset(reset),
        .enable(pc_enable),
        .load(pc_load),
        .load_data(immediate),
        .pc(pc)
    );

    //========================================================
    // Instruction Memory
    //========================================================

    instruction_memory IMEM
    (
        .clk(clk),
        .address(pc),
        .instruction(instruction)
    );

    //========================================================
    // Instruction Decoder
    //========================================================

    decoder DECODER
    (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .immediate(immediate)
    );

    //========================================================
    // Control Unit
    //========================================================

    control_unit CONTROL
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

    //========================================================
    // Register File
    //========================================================

    register_file REGFILE
    (
        .clk(clk),
        .reset(reset),

        .write_enable(reg_write),

        .read_addr1(rs1),
        .read_addr2(rs2),

        .write_addr(rd),

        .write_data(write_back_data),

        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    //========================================================
    // ALU
    //========================================================

    alu ALU
    (
        .A(reg_data1),
        .B(alu_src ? immediate : reg_data2),

        .ALU_Sel(alu_sel),

        .Result(alu_result),

        .Carry(carry_flag),
        .Zero(zero_flag),
        .Negative(negative_flag)
    );

 //========================================================
// Flags Register
//========================================================

wire carry;
wire zero;
wire negative;

flags FLAGS
(
    .clk(clk),
    .reset(reset),

    .load(flags_load),

    .carry_in(carry_flag),
    .zero_in(zero_flag),
    .negative_in(negative_flag),

    .carry(carry),
    .zero(zero),
    .negative(negative)
);

    //========================================================
    // Data Memory
    //========================================================

    data_memory DMEM
    (
        .clk(clk),

        .we(mem_write),

        .address(alu_result),

        .write_data(reg_data2),

        .read_data(mem_data)
    );
        //========================================================
    // Write Back Logic
    //========================================================

    assign write_back_data =
            mem_read ? mem_data :
            alu_src  ? immediate :
                       alu_result;

endmodule