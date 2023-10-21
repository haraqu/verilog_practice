module wrapper_mem (
    wrapper_mem_o,
    w_data,
    wrapper_mem_i,
    func3, 
    req,
    r_data,
    store_op,
    wr_en,
    mem_addr,
    clk   
  );

 input wire [2:0]                        func3;
 input wire [13:0]                    mem_addr; 
 output reg [3:0]                     store_op;
 input wire [31:0]                      r_data;
 input wire [31:0]               wrapper_mem_i;
 output reg                              wr_en;
 input wire                                clk;
 output reg [31:0]               wrapper_mem_o;
 output reg [31:0]                      w_data;
 output reg                                req;

 

 always@(*)begin
     store_op = 4'b0;
     req =1 ;
     
     if(func3==3'b000)begin //sb
        wr_en= 1'b1;
           case(mem_addr[1:0])
 
           00:begin 
             store_op=4'b0001;
             w_data = wrapper_mem_i;
             end
           01:begin
             store_op=4'b0010;
             w_data = {wrapper_mem_i[31:16],wrapper_mem_i[7:0],wrapper_mem_i[7:0]};
           end
           10:begin
             store_op=4'b0100;
             w_data = {wrapper_mem_i[31:24],wrapper_mem_i[7:0],wrapper_mem_i[15:0]};
           end
           11:begin
             store_op=4'b1000;
             w_data = {wrapper_mem_i[7:0],wrapper_mem_i[23:0]};
           end
           endcase
     end
      if(func3==3'b001)begin//sh
      wr_en= 1'b1;
           case(mem_addr[1:0])
 
           00: begin
             store_op = 4'b0011;
             w_data = wrapper_mem_i;
           end
           01:begin
             store_op = 4'b0110;
             w_data = {wrapper_mem_i[31:24],wrapper_mem_i[15:0],wrapper_mem_i[7:0]};
           end
           10:begin
             store_op=4'b1100;
             w_data = {wrapper_mem_i[15:0],wrapper_mem_i[15:0]};
           end
           endcase
     end
     if(func3==3'b010)begin//sw
     wr_en= 1'b1;
 
       store_op=4'b1111;
       w_data = wrapper_mem_i;   
     end
 
  if(func3==3'b000)begin //lb
  wr_en= 1'b0;
           case(mem_addr[1:0])
 
           00:wrapper_mem_o={{24{r_data[7]}},r_data[7:0]};
           01:wrapper_mem_o={{24{r_data[15]}},r_data[15:8]};
           10:wrapper_mem_o={{24{r_data[23]}},r_data[23:16]};
           11:wrapper_mem_o={{24{r_data[31]}},r_data[31:24]};
 
           endcase
     end
      if(func3==3'b001)begin//lh
      wr_en= 1'b0;
           case(mem_addr[1:0])
 
           00:wrapper_mem_o={{16{r_data[15]}},r_data[15:0]};
           01:wrapper_mem_o={{16{r_data[23]}},r_data[23:8]};
           10:wrapper_mem_o={{16{r_data[31]}},r_data[31:16]};
           endcase
     end
     if(func3==3'b010)begin//lw
     wr_en= 1'b0;
 
        wrapper_mem_o=r_data;
         
     end
     if(func3==3'b010)begin//lbu
     wr_en= 1'b0;
         case(mem_addr[1:0])
 
           00:wrapper_mem_o={24'b0,r_data[7:0]};
           01:wrapper_mem_o={24'b0,r_data[15:8]};
           10:wrapper_mem_o={24'b0,r_data[23:16]};
           11:wrapper_mem_o={24'b0,r_data[31:24]};
 
           endcase
       
         
     end
     if(func3==3'b100)begin//lhu
     wr_en= 1'b0;
         case(mem_addr[1:0])
 
           00:wrapper_mem_o={16'b0,r_data[15:0]};
           01:wrapper_mem_o={16'b0,r_data[23:8]};
           10:wrapper_mem_o={16'b0,r_data[31:16]};
           endcase
       
         
     end
 end
 
 
endmodule