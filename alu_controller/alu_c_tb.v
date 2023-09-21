module alu_controller_tb ();
    
    reg [6:0]fun7;
    reg [2:0]func3;
    reg r_type;
    reg i_type;
    wire [4:0]alu_op;

     alu_controller u_aluc0(
        .fun7(fun7),
        .func3(func3),
        .r_type(r_type),
        .i_type(i_type),
        .alu_op(alu_op)
     );

     initial begin
        func3 = 3'b101;
        fun7 = 7'b000;
        r_type=1;
        i_type=0;
        #10
        $display("alu_op = %b",alu_op);
     end
     initial begin
        $dumpfile("alu_c.vcd");
        $dumpvars(0,alu_controller_tb);
     end
     
     endmodule