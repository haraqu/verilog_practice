module HSD_tb();
  reg tx;
  reg busy;
  wire ready_o;
  wire [7:0]data_o;
  reg [7:0]data_i;
  reg [7:0] data_i2;
  reg ready_i;
  reg clk;
  reg rst;
  wire Rx;

  // Instantiate the module
  HSD_Tx u_Tx (
    .tx(tx),
    .rst(rst),
    .clk(clk),
    .ready_i(ready_i),
    .data_o(data_o),
    .data_i(data_i)
  );
  HSD_Rx u_Rx(
    .clk(clk),
    .rst(rst),
    .data_i2(data_o),
    .busy(busy),
    .ready_o(ready_o)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Testbench initial block
  initial begin
    clk = 0;
    rst = 0;
    data_i = 8'hA;
    busy=1;
    #25;
    rst = 1;
    tx =1;
    #10;
    rst=1;
    #10;
     busy = 0;
    #10;
   
    #10; 
    ready_i = 1;
    #10;
    #20; 
    $finish;
  end
initial begin
    $dumpfile("HSD.vcd");
    $dumpvars(0, HSD_tb);
  end
endmodule
