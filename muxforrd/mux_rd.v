module mux(imm,rd_addr,rd,rd_sel);

input wire [31:0]imm;
input wire [4:0]rd_addr;
input wire rd_sel;
output reg [4:0]rd;

always @(*) begin

  rd = rd_sel ? rd : imm[4:0];

end


endmodule