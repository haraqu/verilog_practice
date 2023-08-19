module sm_tb();
    reg clk;
    reg rst;
    reg [2:0] opcode;
    reg zero;
    wire mem_red;
    wire load_ir;
    wire halt;
    wire inc_pc;
    wire load_ac;
    wire load_pc;
    wire mem_wr;

    sm_controller u_sm_controller0(
        .opcode(opcode),
        .zero(zero),
        .clk(clk),
        .rst(rst),
        .mem_red(mem_red),
        .load_ir(load_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .load_ac(load_ac),
        .load_pc(load_pc),
        .mem_wr(mem_wr)
        
    );

    
    always begin
        #5 clk = ~clk; 
    end

    initial begin
        
        clk = 0;
        rst = 1;
        opcode = 3'b000;
        zero=0;
        rst = 0;
        #10 rst = 1;
        $display("mem_red is %b" ,mem_red);
        $display("load_ir is %b",load_ir);
        $display("halt is %b",halt);
        $display("inc_pc is %b",inc_pc);
        $display("load_ac is %b",load_ac);
        $display("load_pc is %b",load_pc);
        $display("mem_wr is %b",mem_wr);
        $display("current state is = %b",u_sm_controller0.state_reg);
        $display("next state is = %b",u_sm_controller0.n_state);
        opcode = 3'b000; 
        #20;
     
        #20;
        
        #10;
        opcode=3'b111;
        #20;
        $display("mem_red is %b" ,mem_red);
        $display("load_ir is %b",load_ir);
        $display("halt is %b",halt);
        $display("inc_pc is %b",inc_pc);
        $display("load_ac is %b",load_ac);
        $display("load_pc is %b",load_pc);
        $display("mem_wr is %b",mem_wr);
        $display("current state is = %b",u_sm_controller0.state_reg);
        $display("next state is = %b",u_sm_controller0.n_state);
        #20;
        
        #20;

        #20;

        $finish; 
    end
    initial begin
        $dumpfile("sm.vcd");
        $dumpvars(0,sm_tb);
    end

endmodule
