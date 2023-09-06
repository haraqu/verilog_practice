module mux_for_func7 (func7_sel,func7,imm,fun7);

input wire func7_sel;
input wire [6:0]func7;
input wire [31:0]imm;
output reg [6:0]fun7;
always @(*)begin

 fun7 = func7_sel ? imm[11:5] : func7 ;
 
end

endmodule