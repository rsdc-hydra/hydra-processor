module Cache  #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input clk,cache_write,cache_read,
    output hit,
    input [WIDTH-1:0] addr,
    input [WIDTH-1:0] write_data [3:0],
    output [WIDTH-1:0] read_data
);

reg [31:0] cache_mem [15:0];
reg [31:0] victim_mem [3:0];

reg [3:0] cache_valid;
reg [31:0] cache_tag [3:0];
reg victim_valid;
reg [31:0] victim_tag;

wire [31:0] cache_tag_ = addr[31:4];
wire [3:0] cache_index = addr[3:0];
wire [31:0] victim_tag_ = addr[31:2];
wire [1:0] victim_index = addr[1:0];

always @(posedge clk) begin
    if(cache_read) begin
        if (cache_valid[cache_index] && (cache_tag[cache_index] == cache_tag_)) begin
            read_data <= cache_mem[cache_index];
            hit <= 1;
        end else if (victim_valid && (victim_tag == victim_tag_)) begin
            read_data <= victim_mem[victim_index];
            hit <= 1;
        end else begin
            read_data <= 0;
            hit <= 0;
        end
    end
    else if(cache_write) begin
        if(cache_valid[cache_index])begin
            victim_valid <= 1;
            victim_tag <= cache_tag[cache_index];
            // victim_mem[victim_index] <= cache_mem[cache_index];
            for (int i = 0; i < 4; i = i + 1) begin
                victim_mem[i] <= cache_mem[cache_index-victim_index+i];
            end
            cache_valid <= 1;
            cache_tag[cache_index] <= cache_tag_;
            for (int i = 0; i < 4; i = i + 1) begin
                cache_mem[cache_index-victim_index+i] <= write_data[i];
            end
        end
        else begin
            cache_valid <= 1;
            cache_tag[cache_index] <= cache_tag_;
            //cache_mem[cache_index] <= write_data;
            for (int i = 0; i < 4; i = i + 1) begin
                cache_mem[cache_index-victim_index+i] <= write_data[i];
            end
        end
    end
end

endmodule