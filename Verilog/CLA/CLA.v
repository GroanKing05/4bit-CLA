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