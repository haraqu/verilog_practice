module wrapper_mem (
    wrapper_mem_o_for_data_mem_i,
    wrapper_mem_o,
    wrapper_mem_i,
    instruction, 
    data_mem_o,
    mem_write,
    store_op,
    mem_read,
    mem_addr,
    clk   
 );

 input wire [31:0]                 instruction;
 input wire [13:0]                    mem_addr; 
 output reg [3:0]                     store_op;
 input wire [31:0]                  data_mem_o;
 input wire [31:0]               wrapper_mem_i;
 output reg [31:0]               wrapper_mem_o;
 input wire                          mem_write;
 input wire                           mem_read;
 input wire                                clk;
 output reg [31:0]wrapper_mem_o_for_data_mem_i;
 

 always@(*)begin
     store_op = 4'b0;
     if(instruction[14:12]==3'b000)begin //sb
           case(mem_addr[1:0])
 
           00:begin 
             store_op=4'b0001;
             wrapper_mem_o_for_data_mem_i = wrapper_mem_i;
             end
           01:begin
             store_op=4'b0010;
             wrapper_mem_o_for_data_mem_i = {wrapper_mem_i[31:16],wrapper_mem_i[7:0],wrapper_mem_i[7:0]};
           end
           10:begin
             store_op=4'b0100;
             wrapper_mem_o_for_data_mem_i = {wrapper_mem_i[31:24],wrapper_mem_i[7:0],wrapper_mem_i[15:0]};
           end
           11:begin
             store_op=4'b1000;
             wrapper_mem_o_for_data_mem_i = {wrapper_mem_i[7:0],wrapper_mem_i[23:0]};
           end
           endcase
     end
      if(instruction[14:12]==3'b001)begin//sh
           case(mem_addr[1:0])
 
           00: begin
             store_op = 4'b0011;
             wrapper_mem_o_for_data_mem_i = wrapper_mem_i;
           end
           01:begin
             store_op = 4'b0110;
             wrapper_mem_o_for_data_mem_i = {wrapper_mem_i[31:24],wrapper_mem_i[15:0],wrapper_mem_i[7:0]};
           end
           10:begin
             store_op=4'b1100;
             wrapper_mem_o_for_data_mem_i = {wrapper_mem_i[15:0],wrapper_mem_i[15:0]};
           end
           endcase
     end
     if(instruction[14:12]==3'b010)begin//sw
 
       store_op=4'b1111;
       wrapper_mem_o_for_data_mem_i = wrapper_mem_i;   
     end
 
  if(instruction[14:12]==3'b000)begin //lb
           case(mem_addr[1:0])
 
           00:wrapper_mem_o={{24{data_mem_o[7]}},data_mem_o[7:0]};
           01:wrapper_mem_o={{24{data_mem_o[15]}},data_mem_o[15:8]};
           10:wrapper_mem_o={{24{data_mem_o[23]}},data_mem_o[23:16]};
           11:wrapper_mem_o={{24{data_mem_o[31]}},data_mem_o[31:24]};
 
           endcase
     end
      if(instruction[14:12]==3'b001)begin//lh
           case(mem_addr[1:0])
 
           00:wrapper_mem_o={{16{data_mem_o[15]}},data_mem_o[15:0]};
           01:wrapper_mem_o={{16{data_mem_o[23]}},data_mem_o[23:8]};
           10:wrapper_mem_o={{16{data_mem_o[31]}},data_mem_o[31:16]};
           endcase
     end
     if(instruction[14:12]==3'b010)begin//lw
 
        wrapper_mem_o=data_mem_o;
         
     end
     if(instruction[14:12]==3'b010)begin//lbu
         case(mem_addr[1:0])
 
           00:wrapper_mem_o={24'b0,data_mem_o[7:0]};
           01:wrapper_mem_o={24'b0,data_mem_o[15:8]};
           10:wrapper_mem_o={24'b0,data_mem_o[23:16]};
           11:wrapper_mem_o={24'b0,data_mem_o[31:24]};
 
           endcase
       
         
     end
     if(instruction[14:12]==3'b100)begin//lhu
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
       .data_mem_i(wrapper_mem_o_for_data_mem_i),
       .data_mem_o(                  data_mem_o),
       .write_mask(                    store_op)
     );
 
endmodule