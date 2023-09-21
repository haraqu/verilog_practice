module alu(
    alu_op,
    op_a,
    op_b,
    result
    );

    input wire [4:0] alu_op;
    input wire [31:0]  op_a;
    input wire [31:0]  op_b;
    output reg [31:0]result;



    always @(*)begin

    case (alu_op)

        5'b00000 , 5'b01010 :begin //add
            result = op_a + op_b;    
        end
        5'b00001 :begin//sub
            result = op_a - op_b;    
        end
        5'b00010 , 5'b01011 :begin //sll
            result = op_a << op_b[4:0];    
        end
        5'b00011 , 5'b01100 :begin //srl
            result = op_a >> op_b[4:0];    
        end
        5'b00100 , 5'b01101 :begin //sra
            result = op_a >>> op_b[4:0];    
        end
        5'b00101 , 5'b10000 :begin //and
            result = op_a & op_b;    
        end
        5'b00110 , 5'b10010 :begin //or
            result = op_a | op_b;    
        end
        5'b00111 , 5'b10001 :begin //xor
            result = op_a ^ op_b;    
        end
    endcase
    end
endmodule