`timescale 1ns/1ps
`include "Circuit.v"

module Circuit_tb;
    reg a0, b0, a1, b1, a2, b2, a3, b3;
    reg c0;
    reg clk;

    wire s0, s1, s2, s3;
    wire c4, p4, g4_inv;

    Circuit uut(
        .a0(a0), .a1(a1), .a2(a2), .a3(a3),
        .b0(b0), .b1(b1), .b2(b2), .b3(b3),
        .c0(c0),
        .clk(clk),
        .s0(s0), .s1(s1), .s2(s2), .s3(s3),
        .c4(c4), .p4(p4), .g4_inv(g4_inv)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $dumpfile("Circuit_tb.vcd");
        $dumpvars(0, Circuit_tb);
        
        // Test Case 1: 0000 + 0000 + 0
        {a3,a2,a1,a0} = 4'd0;
        {b3,b2,b1,b0} = 4'd0;
        c0 = 0;
        #40; 
        
        // Test Case 2: 0000 + 0001 + 0
        {a3,a2,a1,a0} = 4'd0;
        {b3,b2,b1,b0} = 4'd1;
        c0 = 0;
        #40;
        
        // Test Case 3: 1111 + 0001 + 0
        {a3,a2,a1,a0} = 4'd15;
        {b3,b2,b1,b0} = 4'd1;
        c0 = 0;
        #40;
        
        // Test Case 4: 1010 + 0111 + 1
        {a3,a2,a1,a0} = 4'd10;
        {b3,b2,b1,b0} = 4'd7;
        c0 = 1;
        #40;

        $finish;
    end
    
    initial begin
        $display("\nTime\tCLK\tInputs\t\t\tOutputs");
        $display("----\t---\t------\t\t\t-------");
        $monitor("%0t:\t%b\tA=%b%b%b%b B=%b%b%b%b Cin=%b | Cout=%b Sum=%b%b%b%b",
                 $time,
                 clk,
                 a3,a2,a1,a0, b3,b2,b1,b0, c0,
                 c4, s3,s2,s1,s0);
    end
endmodule