`include "wrapper_mem.v"
module mem(
    wrapper_mem_o,
    wrapper_mem_i,
    data_mem_o,
    mem_write,
    store_op,
    mem_read,
    mem_addr,
    func3, 
    req,
    clk   
);

 input wire [2:0]                        func3;
 input wire [13:0]                    mem_addr; 
 output reg [3:0]                     store_op;
 input wire [31:0]                  data_mem_o;
 input wire [31:0]               wrapper_mem_i;
 input wire                          mem_write;
 input wire                           mem_read;
 input wire                                clk;
 output reg [31:0]               wrapper_mem_o;
 output reg                                req;

assign req = 1 ;

 wrapper_mem  u_wrapper(
    .wrapper_mem_o  (      wrapper_mem_o),
    .wrapper_mem_i  (      wrapper_mem_i),
    .func3          ( instruction[14:12]), 
    .data_mem_o     (         data_mem_o),
    .mem_write      (          mem_write),
    .store_op       (           store_op),
    .mem_read       (           mem_read),
    .mem_addr       (           mem_addr),
    .clk            (                clk)   
  );

  endmodule