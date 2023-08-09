
module sr_register_tb;

    reg clk;
    reg rst;
    reg in;
    wire [3:0] q;


    always #5 clk = ~clk;

    initial begin
        clk=1; rst=1;in=1;
        #10;
        rst=0;in=1;
        #10;
        in=0;
        #10;
        in=0;
        #10;
        in=0;
        #10;

        $finish;
    end
    sr_register u_sr_register0 (
        .clk(clk),
        .rst(rst),
        .in(in),
        .q(q)
    );

    initial begin
        $dumpfile("sr_register.vcd");
        $dumpvars(0, sr_register_tb);
    end

endmodule
