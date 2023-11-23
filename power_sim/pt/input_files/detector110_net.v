/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12-SP4
// Date      : Thu Nov 23 22:11:12 2023
/////////////////////////////////////////////////////////////


module detector110 ( a, clk, reset, w );
  input a, clk, reset;
  output w;
  wire   N18, N19, N20, n1, n2, n3, n4, n5, n6;
  wire   [1:0] state;
  assign w = N20;

  DFF_X1 \state_reg[0]  ( .D(N18), .CK(clk), .Q(state[0]), .QN(n2) );
  DFF_X1 \state_reg[1]  ( .D(N19), .CK(clk), .Q(state[1]), .QN(n1) );
  NAND3_X1 U9 ( .A1(state[0]), .A2(n1), .A3(a), .ZN(n4) );
  NOR2_X1 U10 ( .A1(n1), .A2(n2), .ZN(N20) );
  AOI21_X1 U11 ( .B1(n3), .B2(n4), .A(reset), .ZN(N19) );
  NAND2_X1 U12 ( .A1(state[1]), .A2(n2), .ZN(n3) );
  NOR2_X1 U13 ( .A1(reset), .A2(n5), .ZN(N18) );
  AOI22_X1 U14 ( .A1(n6), .A2(n2), .B1(N20), .B2(a), .ZN(n5) );
  XNOR2_X1 U15 ( .A(n1), .B(a), .ZN(n6) );
endmodule

