module low_clk(input clk,rst_n,output clk_lo);
parameter max = 15; //150/10
parameter count = 0;
  
  always @(posedge clk)
    begin 
      if(!rst_n)
        clk_lo <=1'b0;
      else
        begin         
          count <= count + 1'b1;
          if(count == 15)
            clk_lo = ~clk_lo;
          
        end
      
    end
