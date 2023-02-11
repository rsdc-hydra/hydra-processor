module Cache  #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input clk,cache_write,cache_read,
    input [WIDTH-1:0] addr,
    input [WIDTH-1:0] write_data,
    output [WIDTH-1:0] read_data
);

reg [WIDTH-1:0] cache_mem [3:0][3:0];
reg [WIDTH-1:0] victim_mem [0][3:0];

reg [31:0] temp_mem [0][3:0];
reg [31:0] temp_tag;

reg [3:0] cache_valid;
reg [31:0] cache_tag [3:0];
reg victim_valid;
reg [31:0] victim_tag;

wire [31:0] cache_tag_ = addr[31:6];
wire [3:0] cache_index = addr[5:2];
wire [31:0] victim_tag_ = addr[31:4];
wire [1:0] victim_index = addr[3:2];

wire mem_write,mem_read;
wire [WIDTH-1:0] read_data_,addr_,write_data_;

Data_Mem data_mem(
    .clk(clk),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .addr(addr_),
    .write_data(write_data_),
    .read_data(read_data_)
);

always @(posedge clk) begin
    if(cache_read) begin
        if (cache_valid[cache_index >> 2] && (cache_tag[cache_index >> 2] == cache_tag_)) begin
            read_data <= cache_mem[cache_index[3:2]][cache_index[1:0]];
        end else if (victim_valid && (victim_tag == victim_tag_) && cache_valid[cache_index >> 2]) begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     temp_mem[i] <= victim_mem[i];
            // end
            temp_mem <= {victim_mem[0][0], victim_mem[0][1], victim_mem[0][2], victim_mem[0][3]};
            temp_tag <= victim_tag;
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            // end
            victim_mem <= {cache_mem[cache_index >> 2][0], cache_mem[cache_index >> 2][1], cache_mem[cache_index >> 2][2], cache_mem[cache_index >> 2][3]};
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     cache_mem[4'b(temp_tag[1:0]<<2)+i] <= temp_mem[i];
            // end
            cache_mem[cache_index >> 2] <= temp_mem;
            cache_tag[cache_index >> 2] <= cache_tag_;
            read_data <= cache_mem[cache_index[3:2]][cache_index[1:0]];
        end else if (victim_valid && (victim_tag == victim_tag_) && (cache_valid[cache_index>>2] != 1b'1)) begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     cache_mem[4'b(victim_tag[1:0]<<2)+i] <= victim_mem[i];
            // end
            cache_mem[cache_index >> 2] <= victim_mem;
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <=1;
            read_data <= cache_mem[cache_index[3:2]][cache_index[1:0]];
        end else if (cache_valid[cache_index>>2]) begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            // end
            victim_mem <= cache_mem[cache_index[3:2]][cache_index[1:0]];
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);
            victim_valid <= 1b'1;
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_read <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     cache_mem[((cache_index>>2)<<2)+i] <= read_data_[i];
            // end
            mem_read <=1;
            addr_ <= addr;
            cache_mem[cache_index[3:2]][cache_index[1:0]] <= read_data_;
            cache_tag[cache_index >> 2] <= cache_tag_;
            read_data <= cache_mem[cache_index[3:2]][cache_index[1:0]];
            //cache_tag[cache_index>>2] <= victim_tag[31:2];
        end else begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_read <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     cache_mem[((cache_index>>2)<<2)+i] <= read_data_[i];
            // end
            mem_read <= 1;
            addr_ <= addr;
            cache_mem[cache_index[3:2]][cache_index[1:0]] <= read_data_;
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <=1;
            read_data <= cache_mem[cache_index[3:2]][cache_index[1:0]];
            // read_data <= cache_mem[cache_index];
            // cache_tag[cache_index>>2] <= victim_tag[31:2];
        end
    end
    else if(cache_write) begin
        if((cache_valid[cache_index>>2]) && (cache_tag[cache_index>>2] == cache_tag_) )begin
            cache_mem[cache_index[3:2]][cache_index[1:0]] <= write_data;
            //cache_mem[cache_index] <= write_data;
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_write <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            // end
            mem_write <= 1;
            addr_ <= addr;
            write_data_ <= cache_mem[cache_index[3:2]];
        end else if(victim_valid && (victim_tag == victim_tag_) && cache_valid[cache_index>>2])begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     temp_mem[i] <= victim_mem[i];
            // end
            // temp_tag <= victim_tag;
            temp_mem <= {victim_mem[0][0], victim_mem[0][1], victim_mem[0][2], victim_mem[0][3]};
            temp_tag <= victim_tag;

            // for (integer i = 0; i < 4; i = i + 1) begin
            //     victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            // end
            // victim_tag <= (cache_tag_<<2)+cache_index[1:0];

            victim_mem <= {cache_mem[cache_index >> 2][0], cache_mem[cache_index >> 2][1], cache_mem[cache_index >> 2][2], cache_mem[cache_index >> 2][3]};
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);

            // for (integer i = 0; i < 4; i = i + 1) begin
            //     cache_mem[((cache_index>>2)<<2)+i] <= temp_mem[i];
            // end
            // cache_tag[cache_index>>2] <= temp_tag[31:2];
            // cache_mem[cache_index] <= write_data;
            
            cache_mem[cache_index >> 2] <= temp_mem;
            cache_tag[cache_index >> 2] <= cache_tag_;

            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_write <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            // end

            cache_mem[cache_index[3:2]][cache_index[1:0]] <= write_data;
            mem_write <= 1;
            addr_ <= addr;
            write_data_ <= cache_mem[cache_index[3:2]];

        end else if (victim_valid && (victim_tag == victim_tag_) && (cache_valid[cache_index>>2] != 1b'1)) begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     cache_mem[((cache_index>>2)<<2)+i] <= victim_mem[i];
            // end
            // cache_tag <= victim_tag[31:2];
            // cache_mem[cache_index] <= write_data;

            cache_mem[cache_index >> 2] <= victim_mem;
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <= 1;

            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_write <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            // end

            cache_mem[cache_index[3:2]][cache_index[1:0]] <= write_data;
            mem_write <= 1;
            addr_ <= addr;
            write_data_ <= cache_mem[cache_index[3:2]];

        end else if (cache_valid[cache_index>>2]) begin
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            // end
            victim_mem <= {cache_mem[cache_index >> 2][0], cache_mem[cache_index >> 2][1], cache_mem[cache_index >> 2][2], cache_mem[cache_index >> 2][3]};
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);
            victim_valid <= 1b'1;

            mem_read <= 1;
            addr_ <= addr;
            cache_mem[cache_index[3:2]][cache_index[1:0]] <= read_data_;
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <=1;

            cache_mem[cache_index[3:2]][cache_index[1:0]] <= write_data;

            mem_write <= 1;
            addr_ <= addr;
            write_data_ <= cache_mem[cache_index[3:2]];
            // victim_tag <= (cache_tag_<<2)+cache_index[1:0];
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_read <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     cache_mem[((cache_index>>2)<<2)+i] <= read_data_[i];
            // end
            // cache_tag[cache_index>>2] <= victim_tag[31:2];
            // cache_mem[cache_index] <= write_data;
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_write <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            // end
        end else begin
            mem_read <= 1;
            addr_ <= addr;
            cache_mem[cache_index[3:2]][cache_index[1:0]] <= read_data_;
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <=1;

            cache_mem[cache_index[3:2]][cache_index[1:0]] <= write_data;

            mem_write <= 1;
            addr_ <= addr;
            write_data_ <= cache_mem[cache_index[3:2]];
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_read <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     cache_mem[((cache_index>>2)<<2)+i] <= read_data_[i];
            // end
            // cache_tag[cache_index>>2] <= victim_tag[31:2];
            // cache_valid[cache_index>>2] <=1;
            // cache_mem[cache_index] <= write_data;
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     mem_write <=1;
            //     addr_ <= (addr[31:2]<<2 + i);
            //     write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            // end
        end
    end
end

endmodule