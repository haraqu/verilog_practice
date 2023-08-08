`timescale 1ps/1ps
module alu_tb();
reg [7:0]a;
reg [7:0]b;
reg [2:0]op;
wire[7:0]res;

alu u_alu0(
.a(a),
.b(b),
.op(op),
.res(res)
);

initial begin
    a=8'b00000010; b=8'b00000001; op=3'b000;
    #1;
       $display("Test Case 1: out = %d", res);
       a=8'b00000010; b=8'b00000001; op=3'b001;
       #2;

       $display("Test Case 1: out = %d", res);

end
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);
    end
    
endmodule