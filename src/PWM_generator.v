module PWM_generator(
  input wire [7:0] dp, 
  input reg clk, 
  input wire rst_n,
  input wire burst_en,
  input wire clk_en,
  output reg pwm);
  //add a condition for the enabled clk_lo 
  reg [7:0] counter;  
 
  always @ (posedge clk or negedge rst_n)//chnage sensitivity to be synchronous
    begin 
      if (!rst_n)begin
        counter <= 8'b0;
        pwm <= 1'b0;
      end else if (clk_en) begin
        counter <= counter + 8'd1;
          pwm <= (counter <dp)&& burst_en;
        end
 	end
endmodule

