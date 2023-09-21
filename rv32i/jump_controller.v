module jump_controller(
    instruction,
    branch,
    op_a,
    op_b,
    alu_op
);

input wire [31:0]        op_a;
input wire [31:0]        op_b;
output reg             branch;
input wire [4:0]       alu_op;
input wire [31:0] instruction;

always @(*) begin
    branch=0;
    case (instruction[14:12])
          3'b000 : begin //beq
            if(op_a == op_b) begin
            branch=1;
            end
        end
          3'b001 : begin//bne
            if(op_a != op_b) begin
            branch=1;
            end
        end
          3'b100 : begin//blt
            if(op_a < op_b) begin 
            branch=1;
            end
        end
          3'b101 : begin //bge
            if(op_a >= op_b) begin
            branch=1;
            end
        end
          3'b110 : begin //bltu
            if($unsigned(op_a) < op_b) begin
               branch=1;
            end
          end
          3'b111 : begin //bgeu
            if($unsigned(op_a) >= op_b)begin
            branch=1;
            end
        end
          default : begin 
            branch=0;
            end// Handle any unsupported cases
      endcase
    end

endmodule