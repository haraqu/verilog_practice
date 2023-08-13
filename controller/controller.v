module controller (op,ph,zero,sel,rd,Id_ir,inc_pc,halt,Id_pc,data_e,Id_ac,wr);

input wire [2:0] op;
input wire [2:0] ph;
input wire zero ;
output reg sel;
output reg rd;
output reg Id_ir;
output reg inc_pc;
output reg halt;
output reg Id_pc;
output reg data_e;
output reg Id_ac;
output reg wr;


always @ (*)begin 
if (ph==3'b000) begin
    sel=1;
    rd=0;Id_ir=0;inc_pc=0;halt=0;Id_pc=0;data_e=0;Id_ac=0;wr=0;
end
else if(ph==3'b001)begin
    sel=1;rd=1;
    Id_ir=0;inc_pc=0;halt=0;Id_pc=0;data_e=0;Id_ac=0;wr=0;
end
else if(ph==3'b010)begin
    sel=1;rd=1;Id_ir=1;
    inc_pc=0;halt=0;Id_pc=0;data_e=0;Id_ac=0;wr=0;
end
else if (ph==3'b011)begin
    sel=1;rd=1;Id_ir=1;
    inc_pc=0;halt=0;Id_pc=0;data_e=0;Id_ac=0;wr=0;
end
else if (ph==3'b100)begin
    sel=0;rd=0;Id_ir=0;Id_pc=0;data_e=0;Id_ac=0;wr=0;
    inc_pc=1;
    halt=op;
    if (op==3'b000)begin
        halt=1;
    end
    else 
    halt=0;
    end
else if (ph==3'b101)begin
     sel=0;Id_ir=0;inc_pc=0;halt=0;Id_pc=0;data_e=0;Id_ac=0;wr=0;
     rd=op;
     if(op==3'b011)
     rd=1;
     if (op==3'b100)
     rd=1;
     if(op==3'b101)
     rd=1;
     else
     rd=0;
end
else if (ph==3'b110)begin
    sel=0;Id_ir=0;halt=0;Id_ac=0;wr=0;
    rd=op;
    if(op==3'b011)
     rd=1;
     if (op==3'b100)
     rd=1;
     if(op==3'b101)
     rd=1;
     else
     rd=0;
    inc_pc=op;
    if(op==3'b001)
    inc_pc=1;
    else
    inc_pc=0;
    Id_pc=op;
    if(op==3'b110)
    Id_pc=1;
    else
    Id_pc=0;
    data_e=op;
    if(op==3'b110)
    data_e=1;
    else 
    data_e=0;

end
else begin
    sel=0;Id_ir=0;inc_pc=0;halt=0;
    rd=op;
    if(op==3'b011)
     rd=1;
     if (op==3'b100)
     rd=1;
     if (op==3'b101)
     rd=1;
     else
     rd=0;
    Id_pc=op;
    if(op==3'b111)
    Id_pc=1;
    data_e=op;
    if(op==3'b110)
    data_e=1;
    Id_ac=op;
    if(op==3'b011)
     Id_ac=1;
     if (op==3'b100)
     Id_ac=1;
     if(op==3'b101)
     Id_ac=1;
     else
     Id_ac=0;
     wr=op;
     if(op==3'b110)
        wr=1;
        else
        wr=0;
end
end
endmodule
