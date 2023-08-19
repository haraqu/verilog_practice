module mem(addr,w_data,c_en,clk,wr,r_data,w_mask);
    input wire [7:0] addr;
    input wire [31:0] w_data;
    input wire c_en;
    input wire wr;
    input wire clk;
    output reg [31:0] r_data;
    input wire [31:0] w_mask;


    reg [31:0] mem [255:0];  

    always @(posedge clk) begin
        if (c_en) begin
          
            if (wr) begin
                mem[addr] <= w_data & w_mask;  
            end 
            else begin
                r_data <= mem[addr];  
            end
        end 
        
    end

endmodule
