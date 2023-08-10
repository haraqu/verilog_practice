module fa(A,B,Cin,sum,carry);
input wire A;
input wire B;
input wire Cin;
output wire sum;
output wire carry;

wire s0;
wire c1;
wire c0;

assign s0=A^B;
assign sum = s0^Cin;

assign c0 = A&B;
assign c1 = s0&Cin;
assign carry = c0|c1;

endmodule