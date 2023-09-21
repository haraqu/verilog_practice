module  immidiate_generator_tb(); 


reg [31:0]data_in;
reg imm_sel;
wire [31:0]imm;

immidiate_generator u_ig0(
    .data_in(data_in),
    .imm_sel(imm_sel),
    .imm(imm)
);

initial begin 
    data_in=32'b11111111111111111000000000000000;
    #25;
    imm_sel= 1'b0;
    #30;
    imm_sel =1'b1;
    #30;
end
initial begin
  $dumpfile("imm_gen.vcd");
  $dumpvars(0,immidiate_generator_tb);
end

endmodule