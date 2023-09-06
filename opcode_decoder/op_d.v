module op_d(opcode,r_type,i_type,store,rst);

input wire [6:0] opcode;
input wire rst;
output reg r_type;
output reg i_type;
output reg store;


always @(posedge clk)begin
case(opcode)

    7'b0110011:begin
        r_type=1;i_type=0;load=0;store=0;branch=0;jal=0;jalr=0;aui_pc=0;lui=0;//r_type
    end
    7'b0010011:begin
        r_type=0;i_type=1;load=0;store=0;branch=0;jal=0;jalr=0;aui_pc=0;lui=0;//i_type   
    end
   
    7'b0100011:begin
        r_type=0;i_type=0;load=0;store=1;branch=0;jal=0;jalr=0;aui_pc=0;lui=0;//store
    end
   


endcase
end
endmodule