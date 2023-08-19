module addr_mem(addr,clk,wr,rd,data_in,data_out);
    localparam D = 8;
    localparam A = 5;
    input wire [A-1:0]addr;
    input wire clk;
    input wire wr;
    input wire rd;
    
    input wire [D-1:0]data_in;
    output reg [D-1:0]data_out;

    reg[D-1:0]mem[A-1:0];

   always @(posedge clk) begin
        
            if (wr) begin
                mem[addr] <= data_in; 
            end
            else if (rd) 
                data_out <= mem[addr];     
        end 
        
endmodule