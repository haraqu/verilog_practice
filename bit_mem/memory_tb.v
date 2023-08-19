module mem_tb();

reg [31:0] w_mask;
reg [7:0] addr;
reg [31:0] w_data;
reg c_en;
reg wr;
reg clk;
wire [31:0] r_data;

mem u_mem0(
    .addr(addr),
    .w_data(w_data),
    .wr(wr),
    .r_data(r_data),
    .c_en(c_en),
    .clk(clk),
    .w_mask(w_mask)
);

always
begin
    #5 clk = ~clk;
end

initial begin
    clk = 1;
    c_en = 1;
    wr = 1;
    addr = 8'b00000000;
    w_data = 32'b00001111000011110000111100001111;
    w_mask = 32'b10101010101010101010101010101010;

    #10;
    wr = 0;
    #10;
    addr = 8'b00000000;
    #10;

    
    $display("r_data is %b", r_data);
    
    #20;
    
    #10;
    wr = 1;
    addr = 8'b00000001;
    w_data = 32'b11111111000000000000000000111111;
    #10;
    
    #10;
    wr=0;
    addr = 8'b00000001;
    #10;
    $display("r_data is %b", r_data);
    
    #20;
    $finish;
end

initial begin
    $dumpfile("mem.vcd");
    $dumpvars(0, mem_tb);
end

endmodule
