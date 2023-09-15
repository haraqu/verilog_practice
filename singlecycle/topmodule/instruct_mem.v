module instruct_mem(
    addr_instr_mem,
    instruction,
    instruct_en,
    clk
    );
    input wire [6:0]addr_instr_mem;
    input wire         instruct_en;
    input wire                 clk;
    output reg [31:0]  instruction;

    reg [31:0]mem[127:0];

    initial begin

    $readmemh("instr.mem", mem) ;
    
    end

    always @(posedge clk )begin
     if(instruct_en)begin
     instruction = mem[addr_instr_mem];
     end
    end
endmodule