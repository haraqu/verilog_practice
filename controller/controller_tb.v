`timescale 1ns/1ns

module controller_tb();

  
  reg [2:0] op;
  reg [2:0] ph;
  reg zero;
  
  wire sel;
  wire rd;
  wire Id_ir;
  wire inc_pc;
  wire halt;
  wire Id_pc;
  wire data_e;
  wire Id_ac;
  wire wr;


  controller u_c0 (
    .op(op),
    .ph(ph),
    .zero(zero),
    .sel(sel),
    .rd(rd),
    .Id_ir(Id_ir),
    .inc_pc(inc_pc),
    .halt(halt),
    .Id_pc(Id_pc),
    .data_e(data_e),
    .Id_ac(Id_ac),
    .wr(wr)
  );
  
  initial begin
  op = 0;
  ph = 0;
  zero = 0;

  #10;
  ph = 3'b000;
  op = 3'b000;
   

  #50;
  op = 3'b000; 
  ph = 3'b100;
  #50;
  ph=3'b110;
  op=3'b110;
  #100;
end
initial begin
  $dumpfile("controller.vcd");
  $dumpvars(0,controller_tb);
end

endmodule