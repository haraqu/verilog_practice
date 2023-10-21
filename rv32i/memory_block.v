module mem(
    wrapper_mem_o,
    w_data,
    instruction,
    wrapper_mem_i,
    r_data,
    store_op,
    result,
    wr_en,
    mem_addr,
    op_b,
    func3, 
    req,
    clk   
);

 input wire [2:0]                        func3;
 input wire [13:0]                    mem_addr; 
 output wire[3:0]                     store_op;
 input wire [31:0]                      r_data;
 input wire [31:0]               wrapper_mem_i;
 output wire                             wr_en;
 input wire                                clk;
 output wire[31:0]               wrapper_mem_o;
 output wire                               req;
 input wire [31:0]                      result;
 input wire [31:0]                        op_b;
 input wire[31:0]                  instruction;
 output wire [31:0]                     w_data;


assign req = 1'b1 ;

 wrapper_mem  u_wrapper(
    .wrapper_mem_o     (      wrapper_mem_o),
    .wrapper_mem_i     (               op_b),
    .w_data            (             w_data),
    .func3             ( instruction[14:12]), 
    .r_data            (             r_data),
    .store_op          (           store_op),
    .wr_en             (              wr_en),
    .mem_addr          (       result[13:0]),
    .clk               (                clk)   
  );

  endmodule