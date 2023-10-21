
module core(
    pc,
    rst,
    clk,
    instruct_en,
    req,
    mask,
    mem_data,
    i_data,
    mem_data,
    wr_en,
    w_data,
    f_req,
    f_mask,
    f_wr_en,
    f_w_data,
    f_mem_addr,
    mem_addr
);
input wire                    rst;
input wire                    clk;
input wire            instruct_en;
output wire                   req;
output wire[3:0]             mask;
output wire                 wr_en;
output wire[31:0]          w_data;
input wire [31:0]          i_data;
output wire[13:0]        mem_addr;
output wire                 f_req;
input wire [31:0]        mem_data;
output wire[3:0]           f_mask;
output wire               f_wr_en;
output wire[31:0]        f_w_data;
output wire [31:0]             pc;
output wire[13:0]      f_mem_addr;


wire           branch_taken;
wire [31:0]             imm;
wire [31:0]          result;
wire [31:0]            op_a;
wire [31:0]            op_b;
wire [31:0]     instruction; 
wire              reg_write;
wire               op_b_sel;
wire               op_a_sel;
wire [4:0]           alu_op;
wire [4:0]         rs1_addr;
wire [4:0]         rs2_addr;
wire [4:0]          rd_addr;
wire [1:0]           rd_sel;
wire               mem_read;
wire              mem_write;
wire [31:0]         data_in;
wire                 branch;
wire [3:0]         store_op;
wire [31:0]   wrapper_mem_i;
wire [31:0]   wrapper_mem_o;
wire[31:0]       data_in_rf;
wire [31:0]          r_data;
wire [31:0]        alu_op_b; 
wire [31:0]        alu_op_a;


fetch fetch_s(
    .result      (      result),
    .imm         (         imm),
    .jal         (         jal),
    .jalr        (        jalr),
    .pc          (          pc),
    .branch      (      branch),
    .branch_taken(branch_taken),
    .rst         (         rst),
    .clk         (         clk), 
    .f_mask      (      f_mask),
    .f_wr_en     (     f_wr_en),
    .f_req       (       f_req),
    .f_w_data    (    f_w_data),
    .f_mem_addr  (  f_mem_addr)
);

dec dec_s(
  .instruction   (      i_data),
  .reg_write     (   reg_write),
  .op_b_sel      (    op_b_sel),
  .rs2_addr      (    rs2_addr),
  .rs1_addr      (    rs1_addr),
  .rd_addr       (     rd_addr),
  .op_a_sel      (    op_a_sel),
  .imm           (         imm),
  .alu_op        (      alu_op),
  .rd_sel        (      rd_sel),
  .mem_read      (    mem_read),
  .branch_taken  (branch_taken),
  .jalr          (        jalr),
  .jal           (         jal),
  .mem_write     (   mem_write),
  .en            (          en),
  .rst           (         rst),
  .clk           (         clk),
  .data_in_rf    (  data_in_rf),
  .op_a          (        op_a),
  .op_b          (        op_b),
  .alu_op_b      (    alu_op_b),
  .alu_op_a      (    alu_op_a),
  .branch        (      branch)
);

exe exe_s(
    .alu_op      (      alu_op),
    .alu_op_a    (    alu_op_a),
    .alu_op_b    (    alu_op_b),
    .result      (      result)
);

mem mem_s(
    .wrapper_mem_o   (   wrapper_mem_o),
    .wrapper_mem_i   (   wrapper_mem_i),
    .w_data          (          w_data),
    .wr_en           (           wr_en),
    .store_op        (        store_op),
    .mem_addr        (        mem_addr),
    .r_data          (        mem_data),
    .result          (          result),
    .clk             (             clk),
    .instruction     (     instruction), 
    .req             (             req)  
);
WB u_wb(    
  .wrapper_mem_o   (  wrapper_mem_o),   
  .data_in_rf      (     data_in_rf),
  .rd_sel          (         rd_sel),
  .result          (         result),
  .imm             (            imm),
  .pc              (             pc)
);
endmodule