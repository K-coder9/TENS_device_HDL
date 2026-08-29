module burst_gen(
		input wire clk,
  		input wire mode,//0- continuous 1- burst mode
  		input wire rst_n,
  		output reg burst_en
);
  
  //how long will the bursts take place 
  
 parameter COUNTER_ON = 8'd20;
  parameter COUNTER_OFF = 8'd80;
  
  reg [7:0] count; //counts number of time to allow the burst to be on or off
  
  always @(posedge clk)
    begin if(!rst_n)
      begin
        burst_en <= 1'b1;
        count <= 8'b0;
      end
      //need a default mode 
      else if (!mode)begin
        burst_en <=1'b1;
        count<=8'b0;
        end else begin 
        count <= count + 8'b1;
          if(burst_en && (count == COUNTER_ON)) begin 
            count <= 8'b0;
          	burst_en <= 1'b1;
          end else if (burst_en && (count == COUNTER_OFF)) begin
             count <= 8'b0;
          	 burst_en <= 1'b0;
        end 
      end
    end
endmodule