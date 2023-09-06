module mux_for_func7_tb();

reg [6:0]func7;
reg func7_sel;
reg [31:0]imm;
wire [6:0] fun7;

mux_for_func7 u_mff70(
    .fun7(fun7),
    .func7_sel(func7_sel),
    .imm(imm),
    .func7(func7)
);

initial begin

imm= 32'b11111111111111111000000000000000;
func7= 7'b0001111;
#20;
func7_sel = 0;
#10;
func7_sel=1;
#10;
end
initial begin
    $dumpfile("mux.vcd");
    $dumpvars(0,mux_for_func7_tb);
end


endmodule