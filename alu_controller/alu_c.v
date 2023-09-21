module alu_controller (func3,fun7,r_type,i_type,alu_op);
  input wire [2:0] func3;
  input wire [6:0] fun7;
  input wire r_type;
  input wire i_type;
  output reg [4:0] alu_op;


always @(*) begin
  if (r_type) begin
    case (func3)
      3'b000 : alu_op = (fun7) ? 5'b00001: 5'b00000;// sub//add
      3'b001 : alu_op = 5'b00010;//sll
      3'b010 : alu_op = 5'b01000;//slt
      3'b011 : alu_op = 5'b01001;//sltu
      3'b100 : alu_op = 5'b00111;//xor
      3'b101 : alu_op = (fun7) ? 5'b00100 : 5'b00011;//sra//srl
      3'b110 : alu_op = 5'b00110;//or
      3'b111 : alu_op = 5'b00101;//and
      default : alu_op = 5'bxxxxx; // Handle any unsupported cases
    endcase
  end else if (i_type) begin
    case (func3)
      3'b000 : alu_op = 5'b01010;//addi
      3'b001 : alu_op = 5'b01011;//slli
      3'b010 : alu_op = 5'b01110;//slti
      3'b011 : alu_op = 5'b01111;//sltui
      3'b100 : alu_op = 5'b10001;//xori
      3'b101 : alu_op = (fun7) ? 5'b01101 : 5'b01100;//srai//srli
      3'b110 : alu_op = 5'b10010;//ori
      3'b111 : alu_op = 5'b10000;//andi
      default : alu_op = 5'bxxxxx; // Handle any unsupported cases
    endcase
  end else begin
    // Handle unsupported instruction types
    alu_op = 5'bxxxxx;
  end
end

endmodule
