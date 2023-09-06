module op_d_tb();

reg [6:0] opcode;
reg rst;
wire r_type;
wire i_type;;
wire store;


op_d u_op_d(
    .opcode(opcode),
    .r_type(r_type),
    .i_type(i_type),
    .store(store)
    
);


initial begin
rst=0;
opcode=0;
#15;
rst=1;
#10;
rst=0;
#10
opcode=7'b0110011;
#10;
opcode=7'b0010011;
#10;
opcode=7'b0000011;
#10;
opcode=7'b0100011;
#10;
opcode=7'b1100011;
#10;
opcode=7'b1101111;
#10;
opcode=7'b1100111;
#10;
opcode=7'b0010111;
#10;
opcode=7'b0110111;
#10;
$finish;
end
initial begin

$dumpfile("op_d.vcd");
$dumpvars(0,op_d_tb);
end

endmodule