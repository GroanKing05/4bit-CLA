`timescale 1ns/1ps
`include "D_FF.v"

module d_fftb;
    reg D, CLK, RST;
    wire Q;

    d_ff uut(.D(D), .CLK(CLK), .RST(RST), .Q(Q));
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    initial begin   
        $dumpfile("d_fftb.vcd");
        $dumpvars(0, d_fftb);

        RST = 1; #10;
        RST = 0; #10;
        D = 1; #10;
        D = 0; #10;
        D = 1; #10;
        D = 0; #10;
        D = 1; #10;
        D = 0; #10;

        $finish;
    end
endmodule