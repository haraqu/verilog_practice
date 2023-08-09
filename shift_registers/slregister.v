module slregister (clk,rst,in,q);
    input wire clk;
    input wire rst;
    input wire  in;
    output reg[3:0] q;

    always @(posedge clk) begin
        
         if (rst)
            q=4'b0000;
        else begin
            q={q[2:0],in};
        end
    end

endmodule
