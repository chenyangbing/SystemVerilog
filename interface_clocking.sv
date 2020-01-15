`timescale 1ns/1ps
module des (output reg[3:0] gnt);
    always #1 gnt <= $random;
  endmodule
  
  
  interface _if (input bit clk);
    logic [3:0] gnt;
   
    clocking cb_0 @(posedge clk);
      input #0  gnt;
    endclocking
   
    clocking cb_1 @(posedge clk);
      input #1step gnt;
    endclocking
   

  endinterface  

module tb;
    bit clk;
   
    always #5 clk = ~clk;
    initial   clk <= 0;
   
    _if if0 (.clk (clk));
    des d0  (.gnt (if0.gnt));
   
    initial begin
      fork
        begin
          @(if0.cb_0);
          $display ("cb_0.gnt = 0x%0h", if0.cb_0.gnt);
        end
        begin
          @(if0.cb_1);
          $display ("cb_1.gnt = 0x%0h", if0.cb_1.gnt);
        end
      join
      #10 $finish;
    end
   /* 
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars("1");
    end
   */
  endmodule