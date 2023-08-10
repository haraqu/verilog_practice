
`timescale 1ns/1ps
module upcounter_tb();
reg clk;
reg reset;
wire [2:0] counter;

up_counter dut(
    .clk(clk), 
    .reset(reset), 
    .counter(counter)

);
 
    always #5 clk = ~clk;

initial begin 
clk<=0;
reset<=0;
#5;
reset<=1;
#80;
reset<=0;
#5;
reset<=1;
#80;
$finish;

end
initial begin
    $dumpfile("c.vcd");
    $dumpvars(0,upcounter_tb);
end
endmodule