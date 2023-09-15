`include "alu.v"
`include "registerfile.v"
`include "control_unit.v"
`include "data_mem.v"
`include "instruct_mem.v"
`include "pc.v"
`include "wrapper_mem.v"

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
  wire                           op_b_sel; 
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
  wire[31:0]                   data_in_rf;
  wire                             rd_sel;
  wire[3:0]                      store_op;
  wire                             branch;
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
      .op_a    (      op_a),
      .op_b    (  alu_op_b),
      .result  (    result)
    );
    assign alu_op_b = op_b_sel ? imm : op_b;


 program_counter u_pc (
    .result( result),
    .imm   (    imm),
    .pc    (     pc),
    .branch( branch),
    .rst   (    rst),
    .clk   (    clk) 
);
    instruct_mem u_ir0(
      .addr_instr_mem (            pc[8:2]),
      .instruction    (        instruction),
      .instruct_en    (        instruct_en),
      .clk            (                clk)
      );

  control_unit u_cu (
      .instruction(instruction),
      .reg_write  (  reg_write),
      .op_b_sel   (   op_b_sel),
      .alu_op     (     alu_op),
      .rs1_addr   (   rs1_addr),
      .rs2_addr   (   rs2_addr),
      .imm        (        imm),
      .rd_addr    (    rd_addr),
      .mem_read   (   mem_read),
      .mem_write  (  mem_write),
      .branch     (     branch),
      .rd_sel     (     rd_sel)
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
    
    assign data_in_rf = rd_sel ? result : wrapper_mem_o;

endmodule