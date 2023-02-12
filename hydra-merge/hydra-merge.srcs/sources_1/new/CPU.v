`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2023 23:11:34
// Design Name: 
// Module Name: CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU #(parameter WIDTH = 32,parameter MEM_SIZE=5,parameter REG_FILE_SIZE=5) (
    input clk,
    output [WIDTH-1:0] pc,pc_next,
    output [WIDTH-1:0] ins,
    output [WIDTH-1:0] write_reg_data,
    output [WIDTH-1:0] alu_input_a,alu_input_b,
    output [WIDTH-1:0] imm,
    output alu_src,
    output [6:0] opcode,
    output [WIDTH-1:0] testR,testM,
    output [3:0] alu_cnt,
   output [5:0] alu_control_in
    );

    wire branch,zero;
    // wire [WIDTH-1:0] imm;
    // wire [WIDTH-1:0] pc;
    // wire [WIDTH-1:0] pc_next;

    PC_Unit pc_unit(
        .clk(clk),
        .imm(imm),
        .branch(branch),
        .zero(zero),
        .pc(pc),
        .pc_next(pc_next)
    );

//    wire [WIDTH-1:0] ins;
   Ins_Mem ins_mem(
       .pc(pc),
       .ins(ins)
   );

    wire reg_write;
    wire [REG_FILE_SIZE-1:0] read_reg_addr_1,read_reg_addr_2,write_reg_addr;
	// wire [WIDTH-1:0] write_reg_data;
    wire [WIDTH-1:0] read_reg_data_1,read_reg_data_2;

    assign read_reg_addr_1=ins[19:15];
    assign read_reg_addr_2=ins[24:20];
    assign write_reg_addr=ins[11:7];


    Reg_File ref_file(
        .clk(clk),
        .reg_write(reg_write),
        .read_reg_addr_1(read_reg_addr_1),
        .read_reg_addr_2(read_reg_addr_2),
        .write_reg_addr(write_reg_addr),
        .write_reg_data(write_reg_data),
        .read_reg_data_1(read_reg_data_1),
        .read_reg_data_2(read_reg_data_2),
        .test(testR)
    );

    Immediate_Gen imm_gen(
        .ins(ins),
        .imm(imm)
    );

    // wire [WIDTH-1:0] alu_input_a,alu_input_b;
    wire [2:0] alu_control;
    wire [WIDTH-1:0] alu_result;
    
    



    //Mux0
    Mux mux0(
        .sel(alu_src),
        .i0(read_reg_data_2),
        .i1(imm),
        .out(alu_input_b)
    );

    // wire  [3:0] alu_cnt;
    wire [1:0] alu_op;
    wire [3:0] alu_opcode;

    assign alu_opcode={ins[30],ins[14:12]};
    // Dinuka: opcode chnage to alu_copcode in ALU_Control_Unit

    ALU_Control_Unit alu_control_unit(
        .alu_op(alu_op),
        .alu_opcode(alu_opcode),
        .alu_cnt(alu_cnt),
        .alu_control_in(alu_control_in)
    );

    // Dinuka : a,b=>alu_input_a,b
    //alu_control=>alu_cnt
    //result=>alu_result

    assign alu_input_a=read_reg_data_1;

    ALU alu(
        .a(alu_input_a),
        .b(alu_input_b),
        .alu_cnt(alu_cnt),
        .alu_result(alu_result),
        .zero(zero)
    );

    wire mem_write,mem_read;
    wire [WIDTH-1:0] read_data;

    // Data_Mem data_mem(
    //     .clk(clk),
    //     .mem_write(mem_write),
    //     .mem_read(mem_read),
    //     .addr(alu_result),
    //     .write_data(read_reg_data_2),
    //     .read_data(read_data),
    //     .test(testM)
    // );

    Cache cache(
        .clk(clk),
        .cache_write(mem_write),
        .cache_read(cache_read),
        .addr(alu_result),
        .write_data(write_data),
        .read_data(read_data)
    );

    
    // Mux1
   Mux mux1(
        .sel(mem_to_reg),
        .i0(alu_result),
        .i1(read_data),
        .out(write_reg_data)
    );

    // wire [6:0] opcode;
    wire jump;

    assign opcode=ins[6:0];
    
    Control_Unit control_unit(
        .opcode(opcode),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump)
    );

endmodule
