module program_counter (
    result,
    imm,
    pc,
    branch,
    rst,
    clk 
);
    input wire                   rst;
    input wire                branch;
    input wire                   clk;
    output reg [31:0]             pc;
    input wire [31:0]            imm;
    input wire [31:0]         result;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        pc <= 0;
    end 
    else if(branch && result[0])  begin 
        pc <= pc + imm;
    end
    else
        pc <= pc + 32'd4;
end

endmodule
