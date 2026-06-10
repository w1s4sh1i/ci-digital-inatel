`timescale 1ns / 1ps

module axi4_lite_subordinate (
    input clk,
    input reset,

    // AW
    input awvalid,
    input [31:0] awaddr,
    output awready,
    
    // W
    input wvalid,
    input [31:0] wdata,
    output wready,

    // RESPONSE B
    output bvalid,
    output [1:0] bresp,
    input bready,

    // AR
    input arvalid,
    input [31:0] araddr,
    output arready,

    // R
    output [31:0] rdata,
    output rvalid,
    output [1:0] rresp,
    input rready
);

    // Registradores internos para controle das saídas
    reg awready_s;
    reg wready_s;
    reg bvalid_s;
    reg [1:0] bresp_s;
    reg arready_s;
    reg [31:0] rdata_s;
    reg rvalid_s;
    reg [1:0] rresp_s;

    // Memória do subordinado
    reg [31:0] reg_s [0:31];

    // FLAGS - latch
    reg aw_handshake;
    reg w_handshake;
    reg ar_handshake;

    reg [4:0] aw_index;
    reg [4:0] ar_index;
    
    integer i;

    always @(posedge clk) begin
        if(reset) begin
            awready_s <= 0;
            wready_s <= 0;
            bvalid_s <= 0;
            bresp_s <= 0;
            aw_handshake <= 0;
            w_handshake <= 0;

            arready_s <= 0;
            ar_handshake <= 0;
            rvalid_s <= 0;
            rdata_s <= 32'd0;
            rresp_s <= 2'b00;
            
            for (i = 0; i < 32; i = i + 1)
                reg_s[i] <= 32'd0;

        end else begin
            // AW
            if(~awready_s && awvalid && !aw_handshake) begin
                awready_s <= 1;
            end else begin
                awready_s <= 0;
            end

            if(!aw_handshake && awvalid && awready_s) begin
                aw_handshake <= 1;
                aw_index <= awaddr[6:2];
            end

            // W
            if(~wready_s && wvalid && !w_handshake) begin
                wready_s <= 1;
            end else begin
                wready_s <= 0;
            end

            if(!w_handshake && wvalid && wready_s) begin
                // $display("The write address: %b", aw_index);
                w_handshake <= 1;
            end
            
            if(aw_handshake && w_handshake) begin
                reg_s[aw_index] <= wdata;
            end

            // B - response
            if(!bvalid_s && aw_handshake && w_handshake) begin
                bvalid_s <= 1;
                bresp_s <= 2'b00; // OKAY response
            end

            // B - CLEAR
            if(bvalid_s && bready) begin
                bvalid_s <= 0;
                aw_handshake <= 0;
                w_handshake <= 0;
            end

            // AR
            if(~arready_s && arvalid && !ar_handshake) begin
                arready_s <= 1;
            end else begin
                arready_s <= 0;
            end
            
            // R
            if(!ar_handshake && arvalid && arready_s) begin
                ar_handshake <= 1;
                ar_index <= araddr[6:2];     // address
            end

            if(ar_handshake && !rvalid_s) begin
                // $display("The Read address: %b", ar_index);
                rdata_s <= reg_s[ar_index];
                rvalid_s <= 1;
                rresp_s <= 2'b00;
            end

            if(rvalid_s && rready) begin
                rvalid_s <= 0;
                ar_handshake <= 0;
            end
        end 
    end
    
    assign {awready, wready, bvalid, bresp, arready, rdata, rvalid, rresp} = {awready_s, wready_s, bvalid_s, bresp_s, arready_s, rdata_s, rvalid_s, rresp_s};

endmodule
