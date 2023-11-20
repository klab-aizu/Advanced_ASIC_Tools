module top(
    clk,
    rst_n,
    input1,
    input2,
    output1
  );

  input         clk;
  input         rst_n;
  input  [7:0]  input1;
  input  [7:0]  input2;
  output [7:0]  output1;

  reg [7:0] w_temp1;
  reg [7:0] r_temp2;

  always @ (*) begin
    w_temp1 <=  input1 + input2;
  end

  always @ (posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
        r_temp2 <= 8'd0;
    end else begin
        r_temp2 <= w_temp1;
    end
  end

  genvar g_i;
  generate
  for (g_i = 0; g_i < 8;  g_i=g_i+1) begin: TSV_GEN
    TSV TSV0 (
       .data_in     (r_temp2[g_i]), 
       .data_out    (output1[g_i])
    );
  end
  endgenerate

endmodule
