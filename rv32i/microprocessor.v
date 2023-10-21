
module microprocessor(
clk,
rst,
en
);

input wire              clk;
input wire              rst;
input wire               en;


wire [31:0]     instruction;
wire                   load;
wire           branch_taken;
wire [31:0]              pc;
wire [31:0]             imm;
wire [31:0]          result;
wire [31:0]            op_a;
wire [31:0]            op_b;
wire              reg_write;
wire [31:0]        alu_op_b; 
wire [31:0]        alu_op_a;
wire               op_b_sel;
wire               op_a_sel;
wire [4:0]           alu_op;
wire [4:0]         rs1_addr;
wire [4:0]         rs2_addr;
wire [4:0]          rd_addr;
wire [1:0]           rd_sel;
wire [13:0]      f_mem_addr;
wire [31:0]         data_in;
wire                 branch;
wire [2:0]            func3;
wire [3:0]         store_op;
wire [31:0]      data_mem_o;
wire [31:0]   wrapper_mem_i;
wire [31:0]   wrapper_mem_o;
wire[31:0]       data_in_rf;
wire                  f_req;     
wire                f_wr_en;    
wire[3:0]            f_mask;    
wire[31:0]         f_w_data;  
wire [31:0]        f_r_data; 
wire                    req;     
wire                  wr_en;        
wire[31:0]           w_data;  
wire[3:0]              mask;
wire[31:0]           r_data;
wire                  valid;
wire[13:0]         mem_addr;
wire[31:0]           i_data;
wire[31:0]         mem_data;
wire        instruction_req;

core u_core(
    .rst        (        rst),
    .clk        (        clk),
    .instruct_en(         en),
    .req        (        req),
    .mask       (       mask),
    .wr_en      (      wr_en),
    .w_data     (     w_data),
    .mem_addr   (   mem_addr),
    .i_data     (   f_r_data),
    .f_req      (      f_req),
    .f_mask     (     f_mask),
    .mem_data   (   mem_data),
    .f_wr_en    (    f_wr_en),
    .f_w_data   (   f_w_data),
    .pc         (         pc),
    .f_mem_addr ( f_mem_addr)

);

memory u_intructmem(
    .req      (         f_req),
    .wr_en    (       f_wr_en),
    .mask     (              ),
    .w_data   (              ),
    .r_data   (        r_data),
    .mem_addr (       pc[9:2]), 
    .f_r_data (      f_r_data),
    .clk      (           clk),
    .valid    (              )
);

memory u_datamem(
    .clk     (             clk),
    .req     (             req),
    .mem_addr(     result[9:2]),
    .wr_en   (       mem_write),
    .mask    (        store_op),
    .w_data  (          w_data),
    .r_data  (          r_data),
    .valid   (           valid)
);


endmodule