module  bit_splitter_tb(); 


reg [31:0]data_in;
wire [6:0]opcode;
wire [4:0]rs1_addr;
wire [4:0]rs2_addr;
wire [4:0]rd_addr;
wire [2:0]func3;
wire [6:0]func7;

bit_spliter u_bs0(
    .data_in(data_in),
    .opcode(opcode),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .rd_addr(rd_addr),
    .func3(func3),
    .func7(func7)
);

initial begin 
    data_in=32'b11111111111111111000000000000000;
    #30;
end
initial begin
  $dumpfile("bs.vcd");
  $dumpvars(0,bit_splitter_tb);
end

endmodule