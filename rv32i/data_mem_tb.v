module tb_data_mem();

    // Declare signals for the testbench
    reg clk;
    reg mem_read;
    reg mem_write;
    reg [5:0] load_op;
    reg [5:0] store_op;
    reg [11:0] mem_addr;
    reg [31:0] data_mem_i;
    wire [31:0] data_mem_o;

    // Instantiate the data_mem module
    data_mem dut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .load_op(load_op),
        .store_op(store_op),
        .mem_addr(mem_addr),
        .data_mem_i(data_mem_i),
        .data_mem_o(data_mem_o)
    );

    // Clock generation (adjust the period as needed)
    always begin
        #5 clk = ~clk;
    end

    // Initialize signals
    initial begin
        clk = 0;
        mem_read = 0;
        mem_write = 0;
        load_op = 6'b0;
        store_op = 6'b0;
        mem_addr = 12'b0;
        data_mem_i = 32'b0;
        #15;
        mem_write = 1;
        store_op = 6'b0001; // Example store_op value
        mem_addr = 12'b010101010101; // Example memory address
        data_mem_i = 32'h12345678; // Example data to be written
        #10;

        // Disable write operation
        mem_write = 0;
        #10;

        mem_read = 1;
        load_op = 6'b0110; // Example load_op value
        mem_addr = 12'b010101010101; // Example memory address
        #10;
        $finish;
    end

    // Add assertions or checks as needed
initial begin
        $dumpfile("dm.vcd");
        $dumpvars(0, tb_data_mem);
    end
endmodule
