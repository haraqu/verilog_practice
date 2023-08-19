`timescale 1ns/1ps
module addr_mem_tb();
    reg clk_tb;
    reg rd_tb;
    reg wr_tb;
    reg [7:0] data_in_tb; // Adjusted data width
    reg [4:0] addr;      // Adjusted address width

    wire [7:0] data_out_tb; // Adjusted data width

    addr_mem u_memory0(
        .clk(clk_tb),
        .rd(rd_tb),
        .wr(wr_tb),
        .data_in(data_in_tb),
        .data_out(data_out_tb),
        .addr(addr)
    );

    always begin
        #5 clk_tb = ~clk_tb;
    end

    initial begin
        clk_tb = 0;
        wr_tb = 0;
        rd_tb = 0;
        addr = 5'b00000;
        data_in_tb = 8'b00000000;
        #5;

        wr_tb = 1;
        addr = 5'b00001;
        data_in_tb = 8'b00000001;
        #20;
        #10;

        rd_tb = 1;
        wr_tb=0;
        #20;
        addr = 5'b00001;
        #20;
        rd_tb = 0;
        wr_tb = 1;
        addr = 5'b00000;
        data_in_tb = 8'b11111111;
        #20;

        wr_tb = 1;
        rd_tb=0;
        #10;
        wr_tb=0;
        rd_tb = 1;
        #20;
        addr=5'b00000;
        #20;

        $finish;
    end

    initial begin
        $dumpfile("addr_mem_tb.vcd");
        $dumpvars(0, addr_mem_tb);
    end
endmodule
