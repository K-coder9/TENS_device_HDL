// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module tens_pwm_test_tb;
  logic clk=1'b0;
  logic rst_n;
  logic ena = 1'b1;
  logic [7:0] ui_in;
  logic [7:0] uio_in;

  wire [7:0] uo_out,uio_out,uio_oe;
  
  //variables for timing test  
  realtime burst_end;
  realtime begin_burst,duration;
  
  tt_um_K_coder_9 dut(.ui_in(ui_in),.uo_out(uo_out),.uio_in(uio_in),.uio_out(uio_out),.uio_oe(uio_oe),.ena(ena),.rst_n(rst_n),.clk(clk));
  
  always #13_020.8 clk = ~clk;//maybe 
  //hold rst_n to ensure proper reset of signals 
 initial begin 
   //display time in ms 
  logic [31:0] seed;
  static logic [7:0] pwm_out_count = 8'b0;
  
  rst_n = 1'b0;
  @(posedge clk);
  @(posedge clk);
  rst_n = 1'b1;
  
   //---------------------------------------------------------//
   //                    Duty Ratio Test                      //
   //---------------------------------------------------------//
   
  //set a random value for dp and check the fast mode
   uio_in[0] = 1'b1;
   uio_in[1] = 1'b0;
  @(posedge clk);
    for(int i=0;i<10;i+=1)begin 
      seed = 2;
      ui_in = $random(seed);
    end
    
    // count the output of the duty cycle to check if the ratio out of 256 matches the input dp pins 
    
    // count the clock periods uo_out is high for:
    repeat(256)begin 
      @(posedge clk) 
      if(uo_out)begin 
       	pwm_out_count  = pwm_out_count + 8'b1;
      end
    end
    
    //check if the on count matches the dp set in the beginning 
    
   if((pwm_out_count == ui_in)&&uio_in[0]&&!uio_in[1])
      begin 
        $display("TEST has passed for for high speed");
      end else if((pwm_out_count != ui_in)&&uio_in[0]&&!uio_in[1]) begin 
        $display("TEST has failed. DP entered was %b but the measured output dp was: %b",ui_in,pwm_out_count);
      end else if((pwm_out_count == ui_in)&&!uio_in[0]&&!uio_in[1])begin
       $display("TEST has passed for for low speed");
      end else if((pwm_out_count != ui_in)&&!uio_in[0]&&!uio_in[1])begin
        $display("TEST has failed for low speed. DP entered was %b but the measured output dp was: %b",ui_in,pwm_out_count);
      end
   //------------------------------------------------------------------------------//
   //                                Burst Mode Test                               //
   //---------------------------------------------------------------------------- -//
   
   //if divider correctly creats 100Hz enable the burst should be on for 200 ms
   
   uio_in[1] = 1'b1;
   if(uio_in[1])begin
     @(posedge dut.u_burst_gen.burst_en);
     begin_burst = $realtime;
     $dumpfile("tb.vcd");
     $dumpvars(0,tens_pwm_test_tb);
     
     @(negedge dut.u_burst_gen.burst_en);
   	 burst_end = $realtime;
     duration = burst_end - begin_burst;
     $display("Burst duration lasted: %0t",duration);
     
     if(duration >190_000_000.0 && duration <210_000_000.0)//scaled down comparison to nanoseconds
       $display("The burst test passed");
     else 
       $display("The burst test has failed");
   end else begin
     $display("There was not burst test");
   end
   $finish;
  end 
 
  
endmodule
