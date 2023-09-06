module controlunit_tb();

  // Inputs
  reg [31:0] instruction;

  // Outputs
  wire reg_write;
  wire [31:0]op_b;
  wire [4:0] alu_op;
  wire [4:0] rs1_addr;
  wire [4:0] rs2_addr;
  wire [4:0] rd_addr;

  // Instantiate the controlunit module
  controlunit u_controlunit (
    .instruction(instruction),
    .reg_write(reg_write),
    .op_b(op_b),
    .alu_op(alu_op),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .rd_addr(rd_addr)
  );

  // Initialize signals and perform simulations
  initial begin
  instruction = 32'b01000000100000111101001100010011;
  #20;
  end
  initial begin
    $dumpfile("cu.vcd");
    $dumpvars(0,controlunit_tb);
  end

endmodule
