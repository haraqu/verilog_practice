`timescale 1ns/1ps

module fa_tb();

    reg a_tb;
    reg b_tb;
    reg cin_tb;
    wire sum_tb;
    wire carry_tb;

    fa_tb u_fa0 (
        .A(a_tb),
        .B(b_tb),
        .Cin(cin_tb),
        .sum(sum_tb),
        .carry(carry_tb)
    );

    initial begin
      
        a_tb = 0;
        b_tb = 0;
        cin_tb = 0;
        #2;
        $display("sum_tb value is %b", sum_tb);
        $display("carry_tb value is %b", carry_tb);
        a_tb = 1;
        b_tb = 0;
        cin_tb = 1;
        #3;
        
        $display("sum_tb value is %b", sum_tb);
        $display("carry_tb value is %b", carry_tb);
    end

    initial begin
        $dumpfile("fa.vcd");
        $dumpvars(0, fa_tb);
    end

endmodule
