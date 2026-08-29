module PWM_generator(
  input wire [7:0] dp, 
  input reg clk, 
  input wire rst_n,
  input wire burst_en,
  output reg pwm);
  
  reg [7:0] counter;  
  // the clock period is 20 ns so 50 MHz
  
  // every 20 ns is a cycle 
  always @ (posedge clk)
    begin 
      if (!rst_n)begin
        counter <= 8'b0;
        pwm <= 1'b0;
        end else begin
        counter <= counter + 8'd1;
          pwm <= (counter <dp)&& burst_en;
        end
 	end
endmodule

