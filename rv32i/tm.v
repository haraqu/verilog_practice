`include "alu.v"
`include "registerfile.v"
`include "control_unit.v"
`include "data_mem.v"
`include "instruct_mem.v"
`include "pc.v"
`include "wrapper_mem.v"
`include "jump_controller.v"

module topmodule(
  result,
  rst,
  clk,
  instruct_en
  );

  output wire[31:0]                result;
  input wire                          rst;
  input wire                          clk;
  input wire                  instruct_en;
  wire[31:0]                  instruction;
  wire[31:0]                           pc;
  wire[31:0]               addr_instr_mem;
  wire                          reg_write;
  wire[4:0]                       rd_addr;
  wire[4:0]                      rs1_addr;
  wire[4:0]                      rs2_addr;
  wire[4:0]                        alu_op;
  wire[31:0]                         op_a;
  wire[31:0]                         op_b;
  wire[31:0]                     alu_op_b;
  wire[31:0]                     alu_op_a;
  wire                           op_b_sel;
  wire                           op_a_sel;
  wire[31:0]                      data_in;
  wire[31:0]                          imm;
  wire[6:0]                       address;
  wire[31:0]                   data_mem_i;
  wire[31:0]                   data_mem_o;
  wire[31:0]                wrapper_mem_i;
  wire[31:0]                wrapper_mem_o;
  wire[11:0]                     mem_addr;
  wire                           mem_read;
  wire                          mem_write;
  reg [31:0]                   data_in_rf;
  wire[1:0]                        rd_sel;
  wire[3:0]                      store_op;
  wire                             branch;
  wire                       branch_taken;
  wire                               jalr;
  wire                                jal;
  wire[31:0] wrapper_mem_o_for_data_mem_i;

  registerfile U_rf0(
      .rst     (       rst),
      .clk     (       clk),
      .en      ( reg_write),
      .data_in (data_in_rf),
      .rd_addr (   rd_addr),
      .rs1_addr(  rs1_addr),
      .rs2_addr(  rs2_addr),
      .op_a    (      op_a),
      .op_b    (      op_b)
  );
  alu u_alu (
      .alu_op  (    alu_op),
      .op_a    (  alu_op_a),
      .op_b    (  alu_op_b),
      .result  (    result)
    );

    assign alu_op_b = op_b_sel ? imm : op_b;
    assign alu_op_a = op_a_sel ? pc  : op_a;

  jump_controller u_jc(
      .instruction       (       instruction),
      .op_a              (              op_a),
      .op_b              (              op_b),
      .branch            (            branch)
  );


  program_counter u_pc (
      .branch_taken ( branch_taken),
      .result       (       result),
      .imm          (          imm),
      .pc           (           pc),
      .branch       (       branch),
      .jal          (          jal),
      .jalr         (         jalr),
      .rst          (          rst),
      .clk          (          clk) 
  );
  instruct_mem u_ir0(
      .addr_instr_mem (            pc[8:2]),
      .instruction    (        instruction),
      .instruct_en    (        instruct_en),
      .clk            (                clk)
  );

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
      .rd_sel            (            rd_sel)
  );
  wrapper_mem  u_wm0(
      .instruction                 (                 instruction),
      .mem_addr                    (                result[13:0]),
      .store_op                    (                    store_op),
      .wrapper_mem_o               (               wrapper_mem_o),
      .wrapper_mem_i               (                        op_b),
      .mem_write                   (                   mem_write),
      .mem_read                    (                    mem_read),
      .wrapper_mem_o_for_data_mem_i(wrapper_mem_o_for_data_mem_i),
      .clk                         (                         clk)
  );
    
  always @(*)begin
  if(rd_sel==2'b00)begin
  data_in_rf = result ;
  end
  else if (rd_sel==2'b01)begin
  data_in_rf = wrapper_mem_o;
  end
  else if (rd_sel==2'b10)begin
  data_in_rf = imm;
  end
  else if (rd_sel==2'b11)begin
  data_in_rf = pc + 4;
  end
  end
endmodule