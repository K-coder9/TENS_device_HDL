
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
  wire burst_en;
  wire pwm_out;
  wire burst_clk_en;
  
  
  //clk enable mux 
  wire clk_enable = uio_in[0]?1:clk_lo;

  low_clk #(.MAX(9'd14)) u_low_clk(
    .clk(clk),
    .rst_n(rst_n),
    .clk_tick(clk_lo)
  );
  
  low_clk #(.MAX(9'd383)) u_burst_clk(//get 100Hz
    .clk(clk),
    .rst_n(rst_n),
    .clk_tick(burst_clk_en)
  );// 1 burst a second so the u_burst_clk must be 100 Hz 
    
  PWM_generator u_pwm(
    .dp(ui_in),
    .clk(clk),
    .clk_en(clk_enable),
    .rst_n(rst_n),
    .burst_en(burst_en),
    .pwm(pwm_out)
  );
  
  burst_gen u_burst_gen (
    .clk      (clk),
    .rst_n    (rst_n),
    .mode     (uio_in[1]),
    .clk_en   (burst_clk_en),
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
