`include"pc.v"
module fetch(
    result,
    imm,
    jal,
    jalr,
    pc,
    branch,
    branch_taken,
    rst,
    req,
    mask,
    wr_en,
    w_data,
    mem_addr,
    clk 
);
    input wire                   rst;
    input wire                branch; 
    input wire          branch_taken;
    input wire                   jal;
    input wire                  jalr;
    input wire                   clk;
    output reg [31:0]             pc;
    input wire [31:0]            imm;
    input wire [31:0]         result;
    output wire                  req;
    output wire[3:0]            mask;
    output reg                 wr_en;
    output wire[31:0]         w_data;
    output wire[6:0]        mem_addr;

always @(posedge clk) begin
       if (!rst) 
       wr_en <= 1'b0;
       else if(load)
       req=1;
       else
       wr_en <= 1'b1;
end

assign mask = 4'b1111;
assign mem_addr = pc;
assign w_data = instruction;

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