module program_counter (
    result,
    imm,
    jal,
    jalr,
    pc,
    auipc,
    branch,
    branch_taken,
    rst,
    clk 
);
    input wire                   rst;
    input wire                branch;
    input wire                 auipc;
    input wire          branch_taken;
    input wire                   jal;
    input wire                  jalr;
    input wire                   clk;
    output reg [31:0]             pc;
    input wire [31:0]            imm;
    input wire [31:0]         result;

always @(posedge clk ) begin
    if (!rst) begin
        pc <= -4;
    end 
    else if(branch && branch_taken)  begin 
        pc <= result;
    end
    else if(auipc)begin
        pc <= result;
    end
    else if(jal)begin
        pc <= result;
    end
    else if(jalr)begin
        pc <= result;
    end
    else
        pc <= pc + 32'd4;
end

endmodule
