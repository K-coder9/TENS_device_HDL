module low_clk(input clk,rst_n,output reg clk_lo);
//parameters cannot be changed they are constants 
  
  
parameter MAX = 8'd7; //150/10
reg [7:0] count = 8'd0;
  
  always @(posedge clk)
    begin if(!rst_n) begin
        clk_lo <=1'b0;
        count <= 8'd0;
    end else if (count == MAX)
            begin
            	clk_lo <= ~clk_lo;
              	count <= 8'd0;
            end
      else begin
           count <= count + 1'b1;
        end 
             
    end
endmodule 