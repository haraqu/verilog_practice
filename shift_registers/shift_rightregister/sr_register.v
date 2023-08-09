module sr_register (clk,rst,in,q);
    input wire clk;
    input wire rst;
    input wire  in;
    output reg[3:0] q;

    always @(posedge clk) begin
        
         if (rst)
            q=4'b0000;
        else begin

            q={in,q[3:1]};
        end
    end

endmodule
