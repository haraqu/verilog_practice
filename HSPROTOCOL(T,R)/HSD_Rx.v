module HSD_Rx (clk,rst,data_i2,busy,ready_o);
    input wire busy;
    input wire clk;
    input wire rst;
    input wire [7:0] data_i2;
    output reg ready_o;

    reg [7:0] Rx;

   
    always @(*) begin  
                if(busy)
                    ready_o<=0;
                 else
                    ready_o<=1;
               if(ready_o )    
               Rx<=data_i2;
    end
endmodule

