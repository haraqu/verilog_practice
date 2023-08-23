module HSD_Tx (tx,rst,clk,ready_i,data_o,data_i);
    
    localparam IDLE = 2'b00;
    localparam TX = 2'b01;
    localparam VALID = 2'b10;

    input wire tx;
    input wire clk;
    input wire rst;
    input wire [7:0]data_i;
    input wire ready_i;
    output reg [7:0] data_o;

    reg valid_o;
    reg [2:0]state_reg;
    reg [2:0]n_state;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state_reg <= IDLE;
        end
        else begin
            state_reg <= n_state;
        end
    end

        always @(*) begin
        case (state_reg)
            IDLE: begin
                n_state <= TX;
                valid_o=0;
            end
            TX: begin
                valid_o=0;
                if (tx) begin
                    n_state = VALID;
                end
                else begin 
                    n_state = TX;
                end 
            end
            VALID: begin
                valid_o=1;
                data_o <= data_i;
                if (ready_i) begin 
                    n_state=TX;
                end
                else begin
                    n_state=VALID;                   
            end
            end
        endcase
    end

endmodule
