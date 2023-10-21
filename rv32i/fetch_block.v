
module fetch(
    result,
    load,
    imm,
    jal,
    jalr,
    pc,
    branch,
    branch_taken,
    rst,
    f_req,
    f_mask,
    f_wr_en,
    f_w_data,
    f_mem_addr,
    clk 
);
    input wire                   rst;
    input wire                branch; 
    input wire          branch_taken;
    input wire                   jal;
    input wire                  jalr;
    input wire                   clk;
    output wire [31:0]            pc;
    input wire [31:0]            imm;
    input wire [31:0]         result;
    output reg                 f_req;
    output wire[3:0]          f_mask;
    output wire              f_wr_en;
    output wire[31:0]       f_w_data;
    output wire[13:0]     f_mem_addr;
    input wire                  load;
    
assign f_mem_addr = pc[15:2];
assign f_wr_en = 1;
always@(posedge clk )begin
        f_req <= 1'b1;
end
program_counter u_pc (
      .branch_taken (     branch_taken),
      .result       (           result),
      .imm          (              imm),
      .pc           (               pc),
      .branch       (           branch),
      .jal          (              jal),
      .jalr         (             jalr),
      .rst          (              rst),
      .clk          (              clk) 
  );
endmodule