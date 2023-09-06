module registerfile_tb();

reg rst;
reg clk;
reg en;
reg [31:0]data_in;
reg [4:0]rd_addr;
reg [4:0]rs1_addr;
reg [4:0]rs2_addr;
wire [31:0]op_a;
wire [31:0]op_b;

registerfile U_rf0(
    .rst(rst),
    .clk(clk),
    .en(en),
    .data_in(data_in),
    .rd_addr(rd_addr),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .op_a(op_a),
    .op_b(op_b)
);

always begin 
    #5 clk =~clk;

end

initial begin 
clk=0;
rst=0;
en=0;
#35;
en=1;
rd_addr<=5'b00001;
#10;
data_in<=32'b01010101010101010111000111001010;
#10;
rd_addr<=5'b00010;
#10;
data_in<=32'b00000000000000000011111111111111;
#10;
rs1_addr<=5'b00001;
rs2_addr<=5'b00010;
#100;
$finish;
end
initial begin

$dumpfile("singlecycle.vcd");
$dumpvars(0,SINGLECYCLE_tb);

end

endmodule