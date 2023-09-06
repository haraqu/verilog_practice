module mux_tb();


  reg [31:0] imm;
  reg [4:0] rd_addr;
  reg rd_sel;

  wire [4:0] rd;


  mux uut (
    .imm(imm),
    .rd_addr(rd_addr),
    .rd_sel(rd_sel),
    .rd(rd)
  );

  // Initialize signals and perform simulations
  initial begin
    imm = 32'b11111111111111111000001111000000;   
    rd_addr=5'b01011;
    #10; 
    rd_sel=1;
    #10;
    rd_sel=0;
    #10;
    $finish;
  end
    initial begin
    $dumpfile("mux_dump.vcd");
    $dumpvars(0,mux_tb) ;
  end

endmodule
