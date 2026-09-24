`timescale 1ns / 1ps

module double_dabble_tb;
reg CLK100MHZ = 1'b0;
reg ready = 1'b1;
reg reset = 1'b1;
reg [9:0] number = 10'd123;
wire [11:0] number_bcd;

double_dabble #(.NUMBER_SIZE(10), .NUMBER_BCD_SIZE(12))double_dabble_ins(
    .CLK100MHZ(CLK100MHZ), 
    .ready(ready), 
    .reset(reset), 
    .number(number), 
    .number_bcd(number_bcd));

always #5 CLK100MHZ = ~CLK100MHZ;

initial begin 
#10 reset = 1'b0;
#200 ready = 1'b0;
#50;
$finish();
end

endmodule
