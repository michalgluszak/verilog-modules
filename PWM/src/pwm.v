`timescale 1ns / 1ps

module pwm(
    input CLK100MHZ,
    output led_20_proc,
    output led_50_proc,
    output led_80_proc
    );
    
    reg [7:0] counter = 0;
    always @(posedge CLK100MHZ) begin 
        if(counter == 100) begin 
            counter <= 0;
        end else begin 
            counter <= counter + 1;
        end
    end
    
    //20% duty cycle
    assign led_20_proc = (counter < 20) ? 1:0;
    
    //50% duty cycle
    assign led_50_proc = (counter < 50) ? 1:0;
    
    //80% ducty cycle
    assign led_80_proc = (counter < 80) ? 1:0;
    
endmodule
