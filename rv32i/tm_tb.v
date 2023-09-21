
module topmodule_tb();


  reg clk;
  reg rst;
  reg instruct_en;
  wire [31:0] result;

  // Instantiate the topmodule
  topmodule u_topmodule (
    .result(result),
    .clk(clk),
    .instruct_en(instruct_en),
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
    instruct_en=0;
    #25;
    rst = 1;
    instruct_en=1;
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
