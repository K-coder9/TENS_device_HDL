module clock_mux(
				input wire sel,
				input wire clk_high,
  				input wire clk_low,
  output wire pwm_clk);
  
  assign pwm_clk = sel ? clk_high : clk_low;
endmodule