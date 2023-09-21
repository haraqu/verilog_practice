module controlsignaldecoder (i_type,r_type,store,func3,fun7,reg_write,imm_sel,op_b,rd_sel,func7_sel);

input wire r_type;
input wire i_type;
input wire store;=-  
output reg op_b;
output reg reg_write;
output reg rd_sel;
output reg imm_sel;
output reg func7_sel;

alu_controller u_alu_c(
    .fun7(fun7),
    .func3(func3),
    .r_type(r_type),
    .i_type(i_type),
    .alu_op(alu_op)

);
always @(*)begin
if(r_type)begin
    reg_write=1;
    op_b=0;
    rd_sel=1;
    func7_sel=0;
end
else if(i_type)begin
    reg_write=1;
    op_b=1;
    rd_sel=1;
    imm_sel=0;
end
else begin
    reg_write=1;
    op_b=0;
    rd_sel=0;
    imm_sel=1;
    func7_sel=1;
end  
end   

endmodule