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

