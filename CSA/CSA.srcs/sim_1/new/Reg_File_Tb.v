`timescale 1ns / 1ps

module Reg_File_Tb;
  reg clk, reg_write;
  reg [4:0] read_reg_addr_1, read_reg_addr_2, write_reg_addr;
  reg [31:0] write_reg_data;

  wire [31:0] read_reg_data_1, read_reg_data_2;

  parameter period = 100;
  parameter clk_period = 10;
  
  Reg_File reg_file (
    .clk(clk), .reg_write(reg_write),
    .read_reg_addr_1(read_reg_addr_1),
    .read_reg_addr_2(read_reg_addr_2),
    .write_reg_addr(write_reg_addr),
    .write_reg_data(write_reg_data),
    .read_reg_data_1(read_reg_data_1),
    .read_reg_data_2(read_reg_data_2)
  );

  initial begin
  
  //1
    read_reg_addr_1 = 0;
    read_reg_addr_2= 1;
    write_reg_addr= 0;
    write_reg_data=25;
    reg_write = 1;
    clk=1;
    #clk_period;
    clk=0;
    #period;
   //2 
    read_reg_addr_1 = 0;
    read_reg_addr_2= 1;
    write_reg_addr= 1;
    write_reg_data=35;
    reg_write = 0;
    clk=1;
    #clk_period;
    clk=0;
    #period;
    //3
    read_reg_addr_1 = 0;
    read_reg_addr_2= 1;
    write_reg_addr= 1;
    write_reg_data=35;
    reg_write = 1;
    clk=1;
    #clk_period;
    clk=0;
    #period;
    
  end

endmodule

