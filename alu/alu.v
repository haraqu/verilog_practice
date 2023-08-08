module alu(a,b,op,res);
 input wire[7:0]a;
 input wire[7:0]b;
 input wire[2:0]op;
 output reg[7:0]res;

 always@*
 begin
    case(op)
    3'b000:begin
        res=a+b;
    end
    3'b001:begin
        res=a-b;
    end
    3'b010:begin
        res=a&b;
    end
    3'b011:begin
        res=a|b;
    end
    3'b100:begin
        res=a^b;
    end
    3'b101:begin
        res=a<<b;
    end
    default:begin
        res=a>>b;
    end
    endcase
 end
endmodule