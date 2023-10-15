`include "control_unit.v"
`include "registerfile.v"
`include "jump_controller.v"
module dec(
  instruction,
  reg_write,
  op_b_sel,
  rs2_addr,
  rs1_addr,
  rd_addr,
  op_a_sel,
  imm,
  req,
  alu_op,
  rd_sel,
  mem_read,
  branch_taken,
  jalr,
  jal,
  mem_write,
  data_in,
  op_a,
  clk,
  en,
  rst,
  op_b,
  branch

);

  wire [31:0] instruction; 
  wire                req;
  wire               jalr;
  wire                jal;
  wire          reg_write;
  wire [31:0]         imm;
  wire           op_b_sel;
  wire           op_a_sel;
  wire [4:0]       alu_op;
  wire [4:0]     rs1_addr;
  wire [4:0]     rs2_addr;
  wire [4:0]      rd_addr;
  wire [1:0]       rd_sel;
  wire           mem_read;
  wire          mem_write;
  wire       branch_taken;
  wire                clk;
  wire                rst;
  wire                 en;
  wire      [31:0]data_in;
  wire         [31:0]op_a;
  wire         [31:0]op_b;
  wire             branch;



assign alu_op_b = op_b_sel ? imm : op_b;
assign alu_op_a = op_a_sel ? pc  : op_a;



control_unit u_cu (
      .branch_taken      (      branch_taken),
      .jal               (               jal),
      .instruction       (     instruction_o),
      .reg_write         (         reg_write),
      .op_b_sel          (          op_b_sel),
      .op_a_sel          (          op_a_sel),
      .alu_op            (            alu_op),
      .rs1_addr          (          rs1_addr),
      .jalr              (              jalr),
      .rs2_addr          (          rs2_addr),
      .imm               (               imm),
      .rd_addr           (           rd_addr),
      .mem_read          (          mem_read),
      .mem_write         (         mem_write),
      .rd_sel            (            rd_sel)
  );

  registerfile U_rf0(
      .rst     (            rst),
      .clk     (            clk),
      .en      (      reg_write),
      .data_in (     data_in_rf),
      .rd_addr (        rd_addr),
      .rs1_addr(       rs1_addr),
      .rs2_addr(       rs2_addr),
      .op_a    (           op_a),
      .op_b    (           op_b)
  );     

  jump_controller u_jc(
      .instruction       (     instruction_o),
      .op_a              (              op_a),
      .op_b              (              op_b),
      .branch            (            branch)
  );
endmodule