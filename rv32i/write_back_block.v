module  WB (    
  wrapper_mem_o,   
  data_in_rf,
  result,
  imm,
  pc
);

input wire[31:0]       data_in_rf;
output reg[31:0]           result;
input wire[31:0]    wrapper_mem_o;
input wire[31:0]              imm;
input wire[31:0]               pc; 

always @(*)begin
  if(rd_sel==2'b00)begin
  data_in_rf = result ;
  end
  else if (rd_sel==2'b01)begin
  data_in_rf = wrapper_mem_o;
  end
  else if (rd_sel==2'b10)begin
  data_in_rf = imm;
  end
  else if (rd_sel==2'b11)begin
  data_in_rf = pc + 4;
  end
  end
endmodule