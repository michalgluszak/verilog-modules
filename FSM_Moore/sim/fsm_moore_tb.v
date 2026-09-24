`timescale 1ns / 1ps

module fsm_moore_tb;
reg CLK100MHZ = 1'b0;
reg reset = 1'b1;
wire [1:0] out;

fsm_moore fsm_moore_ins(
    .CLK100MHZ(CLK100MHZ), 
    .reset(reset), 
    .out(out));
    
always #5 CLK100MHZ = ~CLK100MHZ;

initial begin 
#10 reset = 1'b0;
#100;
$finish();
end

endmodule
