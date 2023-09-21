module alu_tb();

  // Inputs
  reg [4:0] alu_op;
  reg [31:0] op_a; 
  reg [31:0] op_b;

  // Outputs
  wire [31:0] result;

  // Instantiate the ALU module
  alu uut (
    .alu_op(alu_op),
    .op_a(op_a),
    .op_b(op_b),
    .result(result)
  );

  // Initialize signals and perform simulations
  initial begin
   op_b = 32'b00000000000000000000000000000001;
   op_a = 32'b00000000000000000000000000000011;
   #10;
   alu_op= 01010;
   #10;
  end

endmodule
