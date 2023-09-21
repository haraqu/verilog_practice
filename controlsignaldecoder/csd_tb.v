module controlsignaldecoder_tb();

  // Inputs
  reg r_type;
  reg i_type;
  reg store;

  // Outputs
  wire reg_write;
  wire  op_b;
  wire  rd_sel;
  wire imm_sel;
  wire func7_sel; // Assuming this is an output in your module

  // Instantiate the module
  controlsignaldecoder uut (
    .r_type(r_type),
    .i_type(i_type),
    .store(store),
    .reg_write(reg_write),
    .rd_sel(rd_sel),
    .op_b(op_b),
    .func7_sel(func7_sel),
    .imm_sel(imm_sel)
  );

  // Initialize signals
  initial begin
    r_type = 1;
    i_type = 0;
    store = 0;
    #20;
    i_type = 1;
    r_type = 0;
    store = 0;
    #20;
    store = 1;
    r_type = 0;
    i_type = 0;
    #20;
  end

initial begin
    $dumpfile("csd.vcd");
    $dumpvars(0,controlsignaldecoder_tb);
end
endmodule
