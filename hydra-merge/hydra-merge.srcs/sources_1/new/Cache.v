module Cache  #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input clk,cache_write,cache_read,
    input [WIDTH-1:0] addr,
    input [WIDTH-1:0] write_data,
    output reg [WIDTH-1:0] read_data
    //output reg [31:0] ct
);
integer i;
reg [31:0] cache_mem [15:0];
reg [31:0] victim_mem [3:0];

reg [31:0] temp_mem [3:0];
reg [31:0] temp_tag;

reg [3:0] index;

reg [3:0] cache_valid;
reg [31:0] cache_tag [3:0];
reg victim_valid;
reg [31:0] victim_tag;

// wire [31:0] cache_tag_ = addr[31:6];
// wire [3:0] cache_index = addr[5:2];
// wire [31:0] victim_tag_ = addr[31:4];
// wire [1:0] victim_index = addr[3:2];

wire [31:0] cache_tag_ = addr[31:4];
wire [3:0] cache_index = addr[3:0];
wire [31:0] victim_tag_ = addr[31:2];
wire [1:0] victim_index = addr[1:0];

reg mem_write,mem_read;
reg addr_,write_data_;
wire [WIDTH-1:0] read_data_;
Data_Mem data_mem(
    .clk(clk),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .addr(addr_),
    .write_data(write_data_),
    .read_data(read_data_)
);

always @(*) begin
    if(cache_read) begin
        if (cache_valid[cache_index>>2] && (cache_tag[cache_index>>2] == cache_tag_)) begin
            read_data <= cache_mem[cache_index];
        end else if (victim_valid && (victim_tag == victim_tag_) && cache_valid[cache_index>>2]) begin
            for (i = 0; i < 4; i = i + 1) begin
                temp_mem[i] <= victim_mem[i];
            end
            temp_tag <= victim_tag;
            for (i = 0; i < 4; i = i + 1) begin
                index<=((cache_index>>2)<<2)+i;
                victim_mem[i] <= cache_mem[index];
                //victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            end
            victim_tag <= (cache_tag_<<2)+cache_index[3:2];
            for (i = 0; i < 4; i = i + 1) begin
                cache_mem[(temp_tag[1:0]<<2)+i] <= temp_mem[i];
            end
            cache_tag[cache_index>>2] <= cache_tag_;
            read_data <= cache_mem[cache_index];
        end else if (victim_valid && (victim_tag == victim_tag_) && (cache_valid[cache_index>>2] != 1)) begin
            for (i = 0; i < 4; i = i + 1) begin
                cache_mem[(victim_tag[1:0]<<2)+i] <= victim_mem[i];
            end
            cache_tag[cache_index>>2] <= cache_tag_;
            cache_valid[cache_index>>2] <= 1;
            read_data <= cache_mem[cache_index];
        end else if (cache_valid[cache_index>>2]) begin
            for (i = 0; i < 4; i = i + 1) begin
                index<=((cache_index>>2)<<2)+i;
                victim_mem[i] <= cache_mem[index];
                //victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            end
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);
            victim_valid <= 1;
            for (i = 0; i < 4; i = i + 1) begin
                mem_read <= 1;
                addr_ <= (addr + 4*i);
                cache_mem[((cache_index>>2)<<2)+i] <= read_data_;
            end
            read_data <= cache_mem[cache_index];
            cache_tag[cache_index>>2] <= cache_tag_;
        end else begin
            for (i = 0; i < 4; i = i + 1) begin
                mem_read <= 1;
                addr_ <= (addr + 4*i);
                cache_mem[((cache_index>>2)<<2)+i] <= read_data_;
            end
            read_data <= cache_mem[cache_index];
            cache_tag[cache_index>>2] <= cache_tag_;
            cache_valid[cache_index>>2] <=1;
        end
    end
    else if(cache_write) begin
        read_data<=0;
        if((cache_valid[cache_index>>2]) && (cache_tag[cache_index>>2] == cache_tag_) )begin
            cache_mem[cache_index] <= write_data;
            for (i = 0; i < 4; i = i + 1) begin
                mem_write <=1;
                addr_ <= (addr + 4*i);
                write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            end
        end else if(victim_valid && (victim_tag == victim_tag_) && cache_valid[cache_index>>2])begin
            for (i = 0; i < 4; i = i + 1) begin
                temp_mem[i] <= victim_mem[i];
            end
            temp_tag <= victim_tag;
            for (i = 0; i < 4; i = i + 1) begin
                index<=((cache_index>>2)<<2)+i;
                victim_mem[i] <= cache_mem[index];
                //victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            end
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);
            for (i = 0; i < 4; i = i + 1) begin
                cache_mem[((cache_index>>2)<<2)+i] <= temp_mem[i];
            end
            cache_tag[cache_index>>2] <= cache_tag_;
            cache_mem[cache_index] <= write_data;
            for (i = 0; i < 4; i = i + 1) begin
                mem_write <=1;
                addr_ <= (addr + 4*i);
                write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            end
        end else if (victim_valid && (victim_tag == victim_tag_) && (cache_valid[cache_index>>2] != 1)) begin
            for (i = 0; i < 4; i = i + 1) begin
                cache_mem[((cache_index>>2)<<2)+i] <= victim_mem[i];
            end
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <= 1;
            cache_mem[cache_index] <= write_data;
            for (i = 0; i < 4; i = i + 1) begin
                mem_write <=1;
                addr_ <= (addr + 4*i);
                write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            end
        end else if (cache_valid[cache_index>>2]) begin
            for (i = 0; i < 4; i = i + 1) begin
                index<=((cache_index>>2)<<2)+i;
                victim_mem[i] <= cache_mem[index];
                //victim_mem[i] <= cache_mem[((cache_index>>2)<<2)+i];
            end
            victim_tag <= ((cache_tag[cache_index >> 2] << 2) + cache_index[3:2]);
            victim_valid <= 1;
            for (i = 0; i < 4; i = i + 1) begin
                mem_read <=1;
                addr_ <= (addr + 4*i);
                cache_mem[((cache_index>>2)<<2)+i] <= read_data_;
            end
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_mem[cache_index] <= write_data;
            for (i = 0; i < 4; i = i + 1) begin
                mem_write <=1;
                addr_ <= (addr + 4*i);
                write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            end
        end else begin
            for (i = 0; i < 4; i = i + 1) begin
                mem_read <=1;
                addr_ <= (addr + 4*i);
                cache_mem[((cache_index>>2)<<2)+i] <= read_data_;
            end
            cache_tag[cache_index >> 2] <= cache_tag_;
            cache_valid[cache_index>>2] <= 1;
            cache_mem[cache_index] <= write_data;
            for (i = 0; i < 4; i = i + 1) begin
                mem_write <=1;
                addr_ <= (addr + 4*i);
                write_data_ <= cache_mem[((cache_index>>2)<<2)+i];
            end
        end
    end
    //ct<=cache_tag[3];
end

endmodule