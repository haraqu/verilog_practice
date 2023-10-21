
module dec(
  instruction,
  load,
  reg_write,
  op_b_sel,
  rs2_addr,
  rs1_addr,
  rd_addr,
  op_a_sel,
  imm,
  req,
  alu_op,
  alu_op_b, 
  alu_op_a,
  rd_sel,
  mem_read,
  branch_taken,
  jalr,
  jal,
  mem_write,
  data_in,
  data_in_rf,
  op_a,
  clk,
  en,
  rst,
  pc,
  op_b,
  branch

);

  input wire [31:0]  instruction; 
  input wire [31:0]   data_in_rf;
  output wire                req;
  output wire               jalr;
  output wire                jal;
  output wire          reg_write;
  output wire [31:0]         imm;
  output wire           op_b_sel;
  output wire           op_a_sel;
  output wire [4:0]       alu_op;
  output wire [4:0]     rs1_addr;
  output wire [4:0]     rs2_addr;
  output wire [4:0]      rd_addr;
  output wire [1:0]       rd_sel;
  output wire           mem_read;
  output wire          mem_write;
  output wire       branch_taken;
  input wire                 clk;
  output wire                rst;
  output wire                 en;
  output wire      [31:0]data_in;
  output wire         [31:0]op_a;
  output wire         [31:0]op_b;
  output wire             branch;
  input wire [31:0]           pc;
  output wire               load;
  output wire [31:0]    alu_op_b; 
  output wire [31:0]    alu_op_a;
  




assign alu_op_b = op_b_sel ? imm : op_b;
assign alu_op_a = op_a_sel ? pc  : op_a;



control_unit u_cu (
      .branch_taken      (      branch_taken),
      .jal               (               jal),
      .instruction       (       instruction),
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
      .load              (              load),
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
      .instruction       (       instruction),
      .op_a              (              op_a),
      .op_b              (              op_b),
      .branch            (            branch)
  );
endmodule