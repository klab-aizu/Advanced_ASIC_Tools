`define CLK_PERIOD 2000

module detector110_tester;
   parameter _QUIT = 0;
   reg clk;
   reg rst_n;
   reg aa;
   wire ww;

   detector110 UUT
     (
      .a     (aa),
      .clk   (clk),
      .reset (rst_n),
      .w     (ww)
      );

   initial begin
      $dumpfile("detector110.vcd");
      $dumpvars(0, detector110_tester);
      aa = 1'b0;
      rst_n = 1'b1;
      clk = 1'b0;
      #(3*`CLK_PERIOD);
      rst_n = 1'b0;

      #(1*`CLK_PERIOD);
      aa = 1'b1;
      #(3*`CLK_PERIOD);
      aa = 1'b0;
      #(5*`CLK_PERIOD);
      aa = 1'b1;
      #(1*`CLK_PERIOD);
      aa = 1'b0;

      if (_QUIT == 1)
          $finish;
      else
          $stop;
   end

   always #(`CLK_PERIOD/2) clk = ~clk;
endmodule // TB_detector110
