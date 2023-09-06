module pc_tb();

  // Define signals for the testbench
  reg rst;
  reg clk;
  wire [31:0]pc;

  // Instantiate the program_counter module
  program_counter u_pc (
    .rst(rst),
    .clk(clk),
    .pc(pc)
  );
 always begin
    #5 clk =~ clk;
 end
  // Initialize the testbench
  initial begin
    rst = 1;
    clk=0;
    #10;
    rst = 0;
    #10;
    #10;
    #10;
    $finish;
  end
initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0, pc_tb);
    end
endmodule
