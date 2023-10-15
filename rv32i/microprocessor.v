`include "core.v"
`include "memory.v"

module microprocessor(
    clk,
    rst,
    en
);

input wire                clk;
input wire                rst;
input wire                 en;

wire [31:0]      instruction;
wire           branch_taken;
wire [31:0]              pc;
wire [31:0]             imm;
wire [31:0]          result;
wire [31:0]            op_a;
wire [31:0]            op_b;
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



core u_core(
    .rst        (        rst),
    .clk        (        clk),
    .instruct_en(instruct_en),
    .req        (        req),
    .mask       (       mask),
    .wr_en      (      wr_en),
    .w_data     (     w_data),
    .mem_addr   (   mem_addr)
);

memory u_intructmem(
    .req      (     req),
    .wr_en    (   wr_en),
    .mask     (    mask),
    .w_data   (  w_data),
    .r_data   (  r_data),
    .valid    (   valid)
);
memory u_datamem(
    .req     (                 req),
    .wr_en   (           mem_write),
    .mask    (            store_op),
    .w_data  (              w_data),
    .r_data  (              r_data),
    .valid   (               valid)
);


endmodule