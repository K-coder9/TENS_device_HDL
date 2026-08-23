// Code your design here
module mux1(input [0:1] sel, input clk_high, input clk_low, output pwm_clk)
//0 is slow 1
  assign pwm_clk = sel[0]?clk_low:clk:high;
