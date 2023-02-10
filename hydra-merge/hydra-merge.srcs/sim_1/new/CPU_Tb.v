`timescale 1ns / 1ps


module CPU_Tb  #(parameter WIDTH = 32,parameter MEM_SIZE=5,parameter REG_FILE_SIZE=5) ();

reg clk;
wire [WIDTH-1:0] pc,pc_next;
wire [WIDTH-1:0] ins;
wire [WIDTH-1:0] write_reg_data;
wire [WIDTH-1:0] alu_input_a,alu_input_b;
wire [WIDTH-1:0] imm;
wire alu_src;
wire [6:0] opcode;
wire [WIDTH-1:0] test;
wire [3:0] alu_cnt;
wire [5:0] alu_control_in;


parameter clk_period=20;

initial begin
    clk=0;
end

always begin
    #clk_period clk=~clk;
end

CPU cpu(
    .clk(clk),
    .pc(pc),
    .ins(ins),
    .write_reg_data(write_reg_data),
    .alu_input_a(alu_input_a),
    .alu_input_b(alu_input_b),
    .imm(imm),
    .alu_src(alu_src),
    .opcode(opcode),
    .test(test),
    .alu_cnt(alu_cnt),
    .alu_control_in(alu_control_in),
    .pc_next(pc_next)
);

endmodule
