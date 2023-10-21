module exe(
    alu_op_a,
    alu_op_b,
    alu_op,
    result
);
    input wire [4:0]    alu_op;
    output wire [31:0]  result;
    input wire [31:0] alu_op_b;
    input wire [31:0] alu_op_a;

    alu u_alu (
      .alu_op  (      alu_op),
      .op_a    (    alu_op_a),
      .op_b    (    alu_op_b),
      .result  (      result)
    );
    endmodule