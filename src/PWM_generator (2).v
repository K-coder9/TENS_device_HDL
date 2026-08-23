module PWM_generator( input wire [7:0] dp, input wire clk, input wire rst, output reg [7:0] pwm);
  
  reg [7:0] counter;  
  // the clock period is 20 ns so 50 MHz
  
  // every 20 ns is a cycle 
  always @ (posedge clk)
    begin 
      if (!rst)
        counter <= 0;
      else begin
        counter <= counter + 1'd1;
        if(counter< dp)
          pwm <= 8'b00000001;
        else 
          pwm <= 8'b00000000;
      end
      
    end
  
  
endmodule
