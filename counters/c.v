module up_counter(clk, reset, counter);
    
input wire clk;
input wire reset;
output reg[2:0] counter;

always @(posedge clk) begin
        if (!reset)
            counter <= 4'b0000; 
        else begin
            counter <= counter + 4'b001; 
        end
    end
endmodule