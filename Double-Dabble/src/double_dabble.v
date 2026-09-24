`timescale 1ns / 1ps

module double_dabble #(parameter NUMBER_SIZE = 10, NUMBER_BCD_SIZE = 12)(
    input CLK100MHZ,
    input ready,
    input reset,
    input [NUMBER_SIZE-1:0] number,
    output reg [NUMBER_BCD_SIZE-1:0] number_bcd
    );
    
    localparam IDLE = 0, SHIFT = 1, ADD = 2, DONE = 3;
    reg [1:0] current_state;
    
    reg[NUMBER_BCD_SIZE-1:0] number_bcd_temp;
    reg[3:0] idx;
    integer i;
    
    always @(posedge CLK100MHZ) begin 
        if(reset) begin 
            number_bcd_temp <= 0;
            number_bcd <= 0;
            idx <= 0;
            current_state <= IDLE;
        end else begin 

            case(current_state)
                IDLE:
                    begin 
                        if(ready) begin 
                            number_bcd_temp <= 0;
                            idx <= NUMBER_SIZE-1;
                            current_state <= SHIFT;
                        end else begin 
                            current_state <= IDLE;
                        end
                    end
                SHIFT:
                    begin 
                        number_bcd_temp <= {number_bcd_temp[NUMBER_BCD_SIZE-2:0], number[idx]};
                        
                        if(idx==0) begin 
                            current_state <= DONE;
                        end else begin 
                            idx <= idx - 1;
                            current_state <= ADD;
                        end
                    end
                ADD:
                    begin 
                        for(i = 0; i < (NUMBER_BCD_SIZE/4); i=i+1) begin 
                            if(number_bcd_temp[(i*4)+:4] >= 5) 
                                number_bcd_temp[(i*4)+:4] <= number_bcd_temp[(i*4)+:4] + 3;
                        end
                        
                        current_state <= SHIFT;
                    end
                DONE:
                    begin 
                        number_bcd <= number_bcd_temp;
                        current_state <= IDLE;
                    end
                default: current_state <= IDLE;
            endcase
        end
    end
    
endmodule
