`include"data_mem.v"
module wrapper_mem (
    wrapper_mem_o,
    wrapper_mem_i,
    func3, 
    data_mem_o,
    store_op,
    wr_en,
    mem_addr,
    clk   
  );

 input wire [2:0]                        func3;
 input wire [13:0]                    mem_addr; 
 output reg [3:0]                     store_op;
 input wire [31:0]                  data_mem_o;
 input wire [31:0]               wrapper_mem_i;
 output reg                              wr_en;
 input wire                                clk;
 output reg [31:0]               wrapper_mem_o;
 

 always@(*)begin
     store_op = 4'b0;
     req =1 ;
     
     if(func3==3'b000)begin //sb
        wr_en= 1'b1;
           case(mem_addr[1:0])
 
           00:begin 
             store_op=4'b0001;
             wrapper_mem_o = wrapper_mem_i;
             end
           01:begin
             store_op=4'b0010;
             wrapper_mem_o = {wrapper_mem_i[31:16],wrapper_mem_i[7:0],wrapper_mem_i[7:0]};
           end
           10:begin
             store_op=4'b0100;
             wrapper_mem_o = {wrapper_mem_i[31:24],wrapper_mem_i[7:0],wrapper_mem_i[15:0]};
           end
           11:begin
             store_op=4'b1000;
             wrapper_mem_o = {wrapper_mem_i[7:0],wrapper_mem_i[23:0]};
           end
           endcase
     end
      if(func3==3'b001)begin//sh
      wr_en= 1'b1;
           case(mem_addr[1:0])
 
           00: begin
             store_op = 4'b0011;
             wrapper_mem_o = wrapper_mem_i;
           end
           01:begin
             store_op = 4'b0110;
             wrapper_mem_o = {wrapper_mem_i[31:24],wrapper_mem_i[15:0],wrapper_mem_i[7:0]};
           end
           10:begin
             store_op=4'b1100;
             wrapper_mem_o = {wrapper_mem_i[15:0],wrapper_mem_i[15:0]};
           end
           endcase
     end
     if(func3==3'b010)begin//sw
     wr_en= 1'b1;
 
       store_op=4'b1111;
       wrapper_mem_o = wrapper_mem_i;   
     end
 
  if(func3==3'b000)begin //lb
  wr_en= 1'b0;
           case(mem_addr[1:0])
 
           00:wrapper_mem_o={{24{data_mem_o[7]}},data_mem_o[7:0]};
           01:wrapper_mem_o={{24{data_mem_o[15]}},data_mem_o[15:8]};
           10:wrapper_mem_o={{24{data_mem_o[23]}},data_mem_o[23:16]};
           11:wrapper_mem_o={{24{data_mem_o[31]}},data_mem_o[31:24]};
 
           endcase
     end
      if(func3==3'b001)begin//lh
      wr_en= 1'b0;
           case(mem_addr[1:0])
 
           00:wrapper_mem_o={{16{data_mem_o[15]}},data_mem_o[15:0]};
           01:wrapper_mem_o={{16{data_mem_o[23]}},data_mem_o[23:8]};
           10:wrapper_mem_o={{16{data_mem_o[31]}},data_mem_o[31:16]};
           endcase
     end
     if(func3==3'b010)begin//lw
     wr_en= 1'b0;
 
        wrapper_mem_o=data_mem_o;
         
     end
     if(func3==3'b010)begin//lbu
     wr_en= 1'b0;
         case(mem_addr[1:0])
 
           00:wrapper_mem_o={24'b0,data_mem_o[7:0]};
           01:wrapper_mem_o={24'b0,data_mem_o[15:8]};
           10:wrapper_mem_o={24'b0,data_mem_o[23:16]};
           11:wrapper_mem_o={24'b0,data_mem_o[31:24]};
 
           endcase
       
         
     end
     if(func3==3'b100)begin//lhu
     wr_en= 1'b0;
         case(mem_addr[1:0])
 
           00:wrapper_mem_o={16'b0,data_mem_o[15:0]};
           01:wrapper_mem_o={16'b0,data_mem_o[23:8]};
           10:wrapper_mem_o={16'b0,data_mem_o[31:16]};
           endcase
       
         
     end
 end
 
     data_mem u_dm (
       .clk       (                         clk),
       .mem_addr  (              mem_addr[13:2]),
       .mem_read  (                    mem_read),
       .mem_write (                   mem_write),
       .data_mem_i(               wrapper_mem_o),
       .data_mem_o(                  data_mem_o),
       .write_mask(                    store_op)
     );
 
endmodule