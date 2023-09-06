module bit_spliter(data_in,rs1_addr,rs2_addr,rd_addr,func3,func7,opcode); 

input wire [31:0]data_in;
output reg [6:0]opcode;
input wire [31:0]imm_s;
input wire [31:0]imm_i;
output reg [4:0]rs1_addr;
output reg [4:0]rs2_addr;
output reg [4:0] rd_addr;
output reg [2:0]func3;
output reg [6:0]func7;


always@(*) begin

if(data_in)
    opcode = {data_in[6:0]};
    rd_addr  = {data_in[11:7]};
    func3 = {data_in[14:12]};
    rs1_addr = {data_in[19:15]};
    rs2_addr = {data_in[24:20]};
    func7 = {data_in[31:25]};
end
endmodule