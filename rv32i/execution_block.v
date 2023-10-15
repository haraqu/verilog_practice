`include "alu.v"
module exe(
    alu_op,
    op_a,
    op_b,
    result
);
    input wire [4:0] alu_op;
    input wire [31:0]  op_a;
    input wire [31:0]  op_b;
    output reg [31:0]result;

    alu u_alu (
      .alu_op  (      alu_op),
      .op_a    (    alu_op_a),
      .op_b    (    alu_op_b),
      .result  (      result)
    );
    endmodule