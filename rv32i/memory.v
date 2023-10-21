module memory (
    mem_addr,
    clk,
    req,
    wr_en,
    mask,
    w_data,
    r_data,
    f_r_data,
    valid
);

input wire             clk;
input wire [7:0]  mem_addr;
input wire             req;
input wire           wr_en;
input wire [3:0]      mask;
input wire [31:0]   w_data; 
output reg [31:0]   r_data;
output reg [31:0] f_r_data;
output reg           valid;

reg [31:0]mem[127:0];


    initial begin

    $readmemh("instr.mem", mem) ;
    
    end   
     always @(*) begin
        f_r_data = mem[mem_addr]; 
     end

always@(posedge clk )begin
      valid <= req ;
      if(req) begin
        if(wr_en) begin
            if (mask[0]) begin
                mem[mem_addr][7:0]<= w_data[7:0];
            end
            if (mask[1])begin
                mem[mem_addr][15:8]<= w_data[15:8];
            end
            if (mask[2])begin
                mem[mem_addr][23:16]<= w_data[23:16];
            end
            if (mask[3])begin
                mem[mem_addr][31:24]<= w_data[31:24];
            end
        end
        else begin
        r_data = mem[mem_addr]; 
        end
    end
end
endmodule