// Positive edge triggered D flip-flop
module d_ff (D, CLK, RST, Q);
  input D, CLK, RST;
  output reg Q;

  always @(posedge CLK or posedge RST) begin
    if (RST)
      Q = 1'b0;
    else
      Q = D;
  end
endmodule