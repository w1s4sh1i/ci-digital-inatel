/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Laboratory
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module slanky (
    input   [15:0]  A,
    input   [15:0]  B,
    input           Cin,
    output  [15:0]  Sum,
    output          Cout
);

    // initialize Generate and Propagate signals
    wire [15:0] G, P;
    assign G = A & B;
    assign P = A ^ B;

    // layer 1
    wire [15:0] P1,G1;
    genvar i; 

    generate

        for (i = 0; i < 16; i = i + 1  ) begin
            if (i % 2 == 0  && i > 1|| i == 0) begin
                assign P1[i] = P[i];
                assign G1[i] = G[i];  
            end else if (i == 1) begin
                GrayCell GrayCell_inst_layer1(
                        .Go(G1[i]),
                        .G_idx(G[i]),
                        .P_idx(P[i]), 
                        .G_fb(P[0] & Cin | G[0])

                ); 
                assign P1[i] = P[i];
            end
            else begin
                BlackCell BlackCell_inst_layer1(
                        .Go(G1[i]), 
                        .Po(P1[i]),
                        .G_idx(G[i]), 
                        .P_idx(P[i]), 
                        .G_fb(G[i - 1]), 
                        .P_fb(P[i - 1])

                );
            end
        end
        
    endgenerate

    // layer 2
    wire [15:0] P2,G2;

    generate

        for (i = 0; i < 16; i = i + 1  ) begin
            if (i % 4 == 2 || i % 4 == 3) begin
                if (i == 2 || i == 3) begin
                    GrayCell GrayCell_inst_layer2(
                            .Go(G2[i]),
                            .G_idx(G1[i]),
                            .P_idx(P1[i]), 
                            .G_fb(G1[i - (i%4 - 1)])
    
                    ); 
                    assign P2[i] = P1[i];
                    
                end else begin
                    BlackCell BlackCell_inst_layer2(
                            .Go(G2[i]), 
                            .Po(P2[i]),
                            .G_idx(G1[i]), 
                            .P_idx(P1[i]), 
                            .G_fb(G1[i- (i%4 - 1)]), 
                            .P_fb(P1[i- (i%4 - 1)])
                    );
                    
                end
            end else begin  
                assign P2[i] = P1[i];
                assign G2[i] = G1[i];  
            end
        end
        
    endgenerate

    // layer 3
    wire [15:0] P3,G3;

    generate

        for (i = 0; i < 16; i = i + 1  ) begin
            if (i % 8 >= 4) begin
                if (i >= 4 && i <= 7) begin
                    GrayCell GrayCell_inst_layer3(
                            .Go(G3[i]),
                            .G_idx(G2[i]),
                            .P_idx(P2[i]), 
                            .G_fb(G2[($floor(i/8)) * 8 + 3])
    
                    ); 
                    assign P3[i] = P2[i];
                    
                end else begin
                    BlackCell BlackCell_inst_layer3(
                            .Go(G3[i]), 
                            .Po(P3[i]),
                            .G_idx(G2[i]), 
                            .P_idx(P2[i]), 
                            .G_fb(G2[($floor(i/8)) * 8 + 3]), 
                            .P_fb(P2[($floor(i/8)) * 8 + 3])
                    );
                    
                end
            end else begin  
                assign P3[i] = P2[i];
                assign G3[i] = G2[i];  
            end
        end
        
    endgenerate



    // layer 4
    wire [15:0] P4,G4;

    generate

        for (i = 0; i < 16; i = i + 1  ) begin
            if (i >= 8) begin
                    GrayCell GrayCell_inst_layer4(
                            .Go(G4[i]),
                            .G_idx(G3[i]),
                            .P_idx(P3[i]), 
                            .G_fb(G3[7])
    
                    ); 
                    assign P4[i] = P3[i];
            end else begin  
                assign P4[i] = P3[i];
                assign G4[i] = G3[i];  
            end
        end
        
    endgenerate

    assign  Sum[0] =  P[0]   ^ Cin;
    assign  Sum[1] =  P[1]   ^ G4[0];
    assign  Sum[2] =  P[2]   ^ G4[1];
    assign  Sum[3] =  P[3]   ^ G4[2];
    assign  Sum[4] =  P[4]   ^ G4[3];
    assign  Sum[5] =  P[5]   ^ G4[4];
    assign  Sum[6] =  P[6]   ^ G4[5];
    assign  Sum[7] =  P[7]   ^ G4[6];
    assign  Sum[8] =  P[8]   ^ G4[7];
    assign  Sum[9] =  P[9]   ^ G4[8];
    assign  Sum[10] = P[10] ^ G4[9];
    assign  Sum[11] = P[11] ^ G4[10];
    assign  Sum[12] = P[12] ^ G4[11]; 
    assign  Sum[13] = P[13] ^ G4[12];
    assign  Sum[14] = P[14] ^ G4[13];
    assign  Sum[15] = P[15] ^ G4[14];
    assign  Cout = G4[15];

    
endmodule

