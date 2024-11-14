// Testbench for the PSG module
`timescale 1ns/1ps
`include "PSG.v"

module PSG_tb;
    reg A, B, C;
    wire P_inv, G_inv, S;

    PSG uut(.A(A), .B(B), .C(C), .P_inv(P_inv), .G_inv(G_inv), .S(S));

    initial begin
        $dumpfile("PSG_tb.vcd");
        $dumpvars(0, PSG_tb);

        A = 0; B = 0; C = 0; #10;
        A = 0; B = 0; C = 1; #10;
        A = 0; B = 1; C = 0; #10;
        A = 0; B = 1; C = 1; #10;
        A = 1; B = 0; C = 0; #10;
        A = 1; B = 0; C = 1; #10;
        A = 1; B = 1; C = 0; #10;
        A = 1; B = 1; C = 1; #10;

        $finish;
    end

endmodule