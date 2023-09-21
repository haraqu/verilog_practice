module immidiate_generator(data_in,imm,imm_sel); 

input wire [31:0]data_in;
output reg [31:0]imm;
input wire imm_sel;

always@(*) begin

case (imm_sel)
    1'b0  :  begin
    imm ={19'b0, data_in[31:20]};
end
    1'b1 : begin
    imm= {19'b0,data_in[31:25],data_in[11:7]}; 
end
endcase
end
endmodule