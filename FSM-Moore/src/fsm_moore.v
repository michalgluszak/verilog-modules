`timescale 1ns / 1ps

module fsm_moore(
    input CLK100MHZ,
    input reset,
    output reg [1:0] out
    );
    
    localparam STATE0 = 0, STATE1= 1, STATE2 = 2, STATE3 = 3;
    reg [1:0] current_state, next_state;
    
    always @(posedge CLK100MHZ) begin
        if(reset) begin 
            current_state <= STATE0;
        end else begin 
            current_state <= next_state;
        end
    end
    
    always @(*) begin
        next_state <= current_state;
        case(current_state)
            STATE0: next_state <= STATE1;
            STATE1: next_state <= STATE2;
            STATE2: next_state <= STATE3;
            STATE3: next_state <= STATE0;
        endcase
    end
    
    always @(*) begin
        case(current_state)
            STATE0: out <= 2'd0;
            STATE1: out <= 2'd1;
            STATE2: out <= 2'd2;
            STATE3: out <= 2'd3;
            default: out <= 2'd0;
        endcase
    end

endmodule
