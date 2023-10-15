module topmodule_tb();


  reg clk;
  reg rst;
  reg en;

  // Instantiate the topmodule
  microprocessor u_mp (
    .clk(clk),
    .en(en),
    .rst(rst)
  );

  // Clock ginstruct_eneration
  always begin
    #5 clk = ~clk;
  end

  // Reset initialization
  initial begin
    rst = 0; 
    clk=0;
    en=0;
    #25;
    rst = 1;
    en=1;
    #20;
    // instruction = 32'b0;
    #300; 
    $finish;
  end
  initial begin
    $dumpfile("tm.vcd");
    $dumpvars(0,topmodule_tb);
  end

endmodule