module low_clk(input clk,rst_n,output reg clk_tick);//generate a tick instead
//parameters cannot be changed they are constants 
  
  
parameter MAX = 9'd0; //150/10
reg [8:0] count = 9'd0;
  
  always @(posedge clk)
    begin if(!rst_n) begin
        clk_tick <=1'b0;
        count <= 9'd0;
    end else if (count == MAX)
            begin
            	clk_tick <=1'b1;//instead of toggle have it generate a pulse
              	count <= 9'd0;
            end
      else begin
        	clk_tick <= 1'b0;
           count <= count + 1'b1;
        end 
             
    end
endmodule 