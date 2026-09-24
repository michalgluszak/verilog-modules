`timescale 1ns / 1ps

module pwm_tb;
reg CLK100MHZ = 1'b0;
wire led_20_proc;
wire led_50_proc;
wire led_80_proc;

pwm uut(.CLK100MHZ(CLK100MHZ), .led_20_proc(led_20_proc), .led_50_proc(led_50_proc), .led_80_proc(led_80_proc));

always #5 CLK100MHZ = ~CLK100MHZ;

endmodule
