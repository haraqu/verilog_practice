module sm_controller(opcode,zero,clk,rst,mem_red,load_ir,halt,inc_pc,load_ac,load_pc,mem_wr);

localparam INST_ADDR = 3'b000;
localparam INST_FETCH = 3'b001;
localparam INST_LOAD = 3'b010;
localparam IDLE = 3'b011;
localparam OP_ADDR = 3'b100;
localparam OP_FETCH = 3'b101;
localparam ALU_OP = 3'b110;
localparam STORE = 3'b111;
input wire clk;
input wire rst;
input wire [2:0]opcode;
input wire zero;
output reg mem_red;
output reg load_ir;
output reg halt;
output reg inc_pc;
output reg load_ac;
output reg load_pc;
output reg mem_wr;
reg [2:0]state_reg;
reg [2:0]n_state;

always @(posedge clk or negedge rst) begin
    if(!rst)begin
        state_reg<=INST_ADDR;
    end
    else begin
        state_reg<=n_state;
    end
end
always @(*)begin

    case(state_reg)
        INST_ADDR:begin
            mem_red=0;load_ir=0;halt=0;inc_pc=0;load_ac=0;load_pc=0;mem_wr=0;
            n_state=INST_FETCH;
        end
        INST_FETCH:begin
            mem_red=1;load_ir=0;halt=0;inc_pc=0;load_ac=0;load_pc=0;mem_wr=0;
            n_state=INST_LOAD;
        end
        INST_LOAD:begin
            mem_red=1;load_ir=1;halt=0;inc_pc=0;load_ac=0;load_pc=0;mem_wr=0;
            n_state=IDLE;
        end
        IDLE:begin
            mem_red=1;load_ir=1;halt=0;inc_pc=0;load_ac=0;load_pc=0;mem_wr=0;
            n_state=OP_ADDR;
        end
        OP_ADDR:begin
            mem_red=0;load_ir=0;inc_pc=1;load_ac=0;load_pc=0;mem_wr=0;
            halt=opcode;
            if(opcode==3'b000)
                halt=1;
                else 
                halt=0;
            n_state=OP_FETCH;
        end
        OP_FETCH:begin
            load_ir=0;halt=0;inc_pc=0;load_ac=0;load_pc=0;mem_wr=0;
            mem_red=opcode;
            if(opcode==3'b010||opcode==3'b011||opcode==3'b100||opcode==3'b101)
            mem_red=1;
            else
            mem_red=0;
            n_state=ALU_OP;
        end
        ALU_OP:begin
            load_ir=0;halt=0;mem_wr=0;
            mem_red=opcode;
            if(opcode==3'b010||opcode==3'b011||opcode==3'b100||opcode==3'b101)
            mem_red=1;
            else
            mem_red=0;
            inc_pc=opcode;
            if(opcode==3'b001 && zero==0)
            inc_pc=1;
            else 
            inc_pc=0;
            load_ac=opcode;
            if(opcode==3'b010||opcode==3'b011||opcode==3'b100||opcode==3'b101)
            load_ac=1;
            else
            load_ac=0;
            load_pc=opcode;
            if(opcode==3'b111)
            load_pc=1;
            else
            load_pc=0;
            n_state=STORE;
        end
        STORE:begin
            mem_red=opcode;
            if(opcode==3'b010||opcode==3'b011||opcode==3'b100||opcode==3'b101)
            mem_red=1;
            else
            mem_red=0;
            load_ir=0;halt=0;
            inc_pc=opcode;
            if(opcode==3'b111)
            inc_pc=1;
            else
            inc_pc=0;
            load_ac=opcode;
            if(opcode==3'b010||opcode==3'b011||opcode==3'b100||opcode==3'b101)
            load_ac=1;
            else
            load_ac=0;
            load_pc=opcode;
            if(opcode==3'b111)
            load_pc=1;
            else
            load_pc=0;
            mem_wr=opcode;
            if(opcode==3'b110)
            mem_wr=1;
            else 
            mem_wr=0;
            n_state=INST_ADDR;
        end
        default: begin
            n_state=INST_ADDR;
        end
    endcase
end






endmodule