module memory (
    req,
    wr_en,
    mask,
    w_data,
    r_data,
    valid
);

input wire [11:0] mem_addr;
output wire            req;
input wire           wr_en;
input wire [3:0]      mask;
input wire [31:0]   w_data; 
output wire[31:0]   r_data;
output wire          valid;

reg [31:0]mem[127:0];


    initial begin

    $readmemh("instr.mem", mem) ;
    
    end

always@(posedge clk )begin
      valid = req ;
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
    end
    always @(*)begin
        if(valid) begin
     r_data = mem[mem_addr];  
        end
    end
endmodule