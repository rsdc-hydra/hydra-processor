`timescale 1ns / 1ps

module Data_Mem_Tb #(parameter WIDTH = 32,parameter MEM_SIZE=5);
    reg clk,mem_write,mem_read;
    reg [WIDTH-1:0] addr,write_data;
    wire [WIDTH-1:0] read_data;

    Data_Mem data_mem(
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    parameter period = 90;
    parameter clk_period = 10;

    initial begin
        // 0
        addr=0;
        write_data='h123;
        mem_write=1;
        mem_read=0;
        clk=1;
        #clk_period
        clk=0;
        #period;

        // 1
        addr=0;
        write_data='h111;
        mem_write=0;
        mem_read=0;
        clk=1;
        #clk_period
        clk=0;
        #period;

        // 2
        addr=0;
        write_data='h222;
        mem_write=0;
        mem_read=1;
        clk=1;
        #clk_period
        clk=0;
        #period;

        // 3
        addr=2;
        mem_write=0;
        mem_read=1;
        clk=1;
        #clk_period
        clk=0;
        #period;

        // 4
        addr=2;
        write_data='h12345678;
        mem_write=1;
        mem_read=1;
        clk=1;
        #clk_period
        clk=0;
        #period;

        // 5
        addr=2;
        write_data='h55;
        mem_write=0;
        mem_read=1;
        clk=1;
        #clk_period
        clk=0;
        #period;

        // 6
        addr=2;
        mem_write=1;
        mem_read=1;
        clk=1;
        #clk_period
        clk=0;
        #period; 

        // 7
        addr=2;
        mem_write=0;
        mem_read=0;
        clk=1;
        #clk_period
        clk=0;
        #period; 


    end


endmodule
