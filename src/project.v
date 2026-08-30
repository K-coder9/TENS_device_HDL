

`default_nettype none

module tt_um_K_coder_9 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  
  
  wire clk_lo;
  wire pwm_clk;
  wire burst_en;
  wire pwm_out;

  low_clk #(.MAX(8'd15)) u_low_clk(
    .clk(clk),
    .rst_n(rst_n),
    .clk_lo(clk_lo)
  );
  
  clock_mux u_clk_mux(
    .sel(uio_in[0]),
    .clk_high(clk),
    .clk_low(clk_lo),
    .pwm_clk(pwm_clk)
  );

  PWM_generator u_pwm(
    .dp(ui_in),
    .clk(pwm_clk),
    .rst_n(rst_n),
    .burst_en(burst_en),
    .pwm(pwm_out)
  );
  burst_gen u_burst_gen (
      .clk      (clk_lo),
      .rst_n    (rst_n),
      .mode     (uio_in[1]),
      .burst_en (burst_en)
  );
  //labelling the pins 
  //ui_in - set duty cycle
  //uio_in [0] - set speed 
  //uio_in [1] - set mode (burst or continuous)
  //uo_out pwm output
  
  //assign the pins 
  assign uo_out = {7'b0,pwm_out};
  assign uio_out = 8'b0;
  assign uio_oe = 8'b0;
                   
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[7:2],1'b0};
  //instantiate your modules
  

endmodule
