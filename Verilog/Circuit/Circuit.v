// PropSumGen to create P, Sum and G for CLA
module PSG(A, B, C, P_inv, G_inv, S);
    input A, B, C;
    output P_inv, G_inv, S;
    wire temp1;   

    nor n1(P_inv, A, B);
    nand n2(G_inv, A, B);
    xor x1(temp1, A, B);
    xor x2(S, temp1, C);
endmodule

module CLA(
    input a0, b0, a1, b1, a2, b2, a3, b3,
    input c0,      
    output s0, s1, s2, s3,
    output c4,     
    output p4,     
    output g4_inv 
);

    wire g0_inv, g1_inv, g2_inv, g3_inv;
    wire p0_inv, p1_inv, p2_inv, p3_inv;
    wire c1, c2, c3;
    wire c0_inv;
    wire temp100, temp101, temp102, temp103, temp104;
    wire temp105, temp106, temp107, temp108, temp109;
    wire temp110, temp111, temp112, temp113;

    PSG psg0(
        .A(a0), .B(b0), .C(c0),
        .P_inv(p0_inv), .G_inv(g0_inv), .S(s0)
    );

    // C1 generation
    not (c0_inv, c0);              
    or (temp100, p0_inv, c0_inv);  
    nand (c1, temp100, g0_inv);    

    PSG psg1(
        .A(a1), .B(b1), .C(c1),
        .P_inv(p1_inv), .G_inv(g1_inv), .S(s1)
    );

    // C2 generation
    nor (temp101, p1_inv, p0_inv);  
    and (temp102, temp101, c0);     
    or (temp103, g0_inv, p1_inv);   
    nand (temp104, temp103, g1_inv); 
    or (c2, temp104, temp102);      

    PSG psg2(
        .A(a2), .B(b2), .C(c2),
        .P_inv(p2_inv), .G_inv(g2_inv), .S(s2)
    );

    // C3 generation
    nor (temp105, p1_inv, p2_inv);  
    and (temp106, temp105, c1);     
    or (temp107, g1_inv, p2_inv);   
    nand (temp108, temp107, g2_inv); 
    or (c3, temp108, temp106);      

    PSG psg3(
        .A(a3), .B(b3), .C(c3),
        .P_inv(p3_inv), .G_inv(g3_inv), .S(s3)
    );

    // P4 (Pout) generation
    nor (temp109, p3_inv, p2_inv);  
    and (p4, temp109, temp101);     

    // G4 (Gout) generation
    and (temp110, temp104, temp109); 
    or (temp111, g2_inv, p3_inv);    
    nand (temp112, temp111, g3_inv); 
    nor (g4_inv, temp112, temp110);  

    // C4 (Cout) generation
    nand (temp113, p4, c0);         
    nand (c4, temp113, g4_inv);     

endmodule

// Positive edge triggered D flip-flop
module d_ff (D, CLK, RST, Q);
  input D, CLK, RST;
  output reg Q;

  initial begin
        Q = 1'b0;  
  end

  always @(posedge CLK or posedge RST) begin
    if (RST)
      Q = 1'b0;
    else
      Q = D;
  end
endmodule

module Circuit(
    input a0, b0, a1, b1, a2, b2, a3, b3,
    input c0,
    input clk,
    output s0, s1, s2, s3,
    output c4,
    output p4,
    output g4_inv
);

    wire a0_reg, b0_reg, a1_reg, b1_reg;
    wire a2_reg, b2_reg, a3_reg, b3_reg;
    wire c0_reg;

    wire s0_cla, s1_cla, s2_cla, s3_cla;
    wire c4_cla, p4_cla, g4_inv_cla;

    // Input flip-flops
    d_ff ff_a0(.D(a0), .CLK(clk), .Q(a0_reg));
    d_ff ff_b0(.D(b0), .CLK(clk), .Q(b0_reg));
    d_ff ff_a1(.D(a1), .CLK(clk), .Q(a1_reg));
    d_ff ff_b1(.D(b1), .CLK(clk), .Q(b1_reg));
    d_ff ff_a2(.D(a2), .CLK(clk), .Q(a2_reg));
    d_ff ff_b2(.D(b2), .CLK(clk), .Q(b2_reg));
    d_ff ff_a3(.D(a3), .CLK(clk), .Q(a3_reg));
    d_ff ff_b3(.D(b3), .CLK(clk), .Q(b3_reg));
    d_ff ff_c0(.D(c0), .CLK(clk), .Q(c0_reg));

    CLA cla_inst(
        .a0(a0_reg), .b0(b0_reg),
        .a1(a1_reg), .b1(b1_reg),
        .a2(a2_reg), .b2(b2_reg),
        .a3(a3_reg), .b3(b3_reg),
        .c0(c0_reg),
        .s0(s0_cla), .s1(s1_cla),
        .s2(s2_cla), .s3(s3_cla),
        .c4(c4_cla),
        .p4(p4_cla),
        .g4_inv(g4_inv_cla)
    );

    d_ff ff_s0(.D(s0_cla), .CLK(clk), .Q(s0));
    d_ff ff_s1(.D(s1_cla), .CLK(clk), .Q(s1));
    d_ff ff_s2(.D(s2_cla), .CLK(clk), .Q(s2));
    d_ff ff_s3(.D(s3_cla), .CLK(clk), .Q(s3));
    d_ff ff_c4(.D(c4_cla), .CLK(clk), .Q(c4));
    d_ff ff_p4(.D(p4_cla), .CLK(clk), .Q(p4));
    d_ff ff_g4(.D(g4_inv_cla), .CLK(clk), .Q(g4_inv));

endmodule