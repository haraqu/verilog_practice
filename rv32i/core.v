`include "fetch_block.v"
`include "decode_block.v"
`include "execution_block.v"
`include "memory_block.v"
`include "write_back_block.v"

module core(
    rst,
    clk,
    instruct_en,
    req,
    mask,
    wr_en,
    w_data,
    mem_addr
);
input wire                rst;
input wire                clk;
input wire        instruct_en;
output wire               req;
output wire[3:0]         mask;
output reg              wr_en;
output wire[31:0]      w_data;
output wire[6:0]     mem_addr;

 
wire           branch_taken;
wire [31:0]              pc;
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
wire [2:0]            func3;
wire [3:0]         store_op;
wire [31:0]      data_mem_o;
wire [31:0]   wrapper_mem_i;
wire [31:0]   wrapper_mem_o;
wire[31:0]       data_in_rf;

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
    .mask        (        mask),
    .wr_en       (       wr_en),
    .w_data      (      w_data),
    .mem_addr    (    mem_addr),
    .req         (         req)
);

dec dec_s(
  .instruction   ( instruction),
  .reg_write     (   reg_write),
  .op_b_sel      (    op_b_sel),
  .rs2_addr      (    rs2_addr),
  .rs1_addr      (    rs1_addr),
  .rd_addr       (     rd_addr),
  .op_a_sel      (    op_a_sel),
  .imm           (         imm),
  .req           (         req),
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
  .rd_addr       (     rd_addr),
  .data_in       (     data_in),
  .rs1_addr      (    rs1_addr),
  .rs2_addr      (    rs2_addr),
  .op_a          (        op_a),
  .op_b          (        op_b),
  .branch        (      branch)
);

exe exe_s(
    .alu_op      (      alu_op),
    .op_a        (        op_a),
    .op_b        (        op_b),
    .result      (      result)
);

mem mem_s(
    .wrapper_mem_o(wrapper_mem_o),
    .wrapper_mem_i(wrapper_mem_i),
    .func3        (        func3), 
    .data_mem_o   (   data_mem_o),
    .mem_write    (    mem_write),
    .store_op     (     store_op),
    .mem_read     (     mem_read),
    .mem_addr     (     mem_addr),
    .clk          (          clk)   
);

endmodule