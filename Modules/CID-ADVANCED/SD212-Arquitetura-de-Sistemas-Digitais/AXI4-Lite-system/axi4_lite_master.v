`timescale 1ns / 1ps

// [ ] Parametrizar as entradas;
// [ ] Reduzir as redundâncias de sinais; 

module axi4_lite_master (
    
    // MASTER output
    output [31:0] rdata_out,
    output read_done, 
    output write_done,
    
    // MASTER INPUT
    input clk, 
    input reset,
    input wr_en,
    input rd_en,
    input [31:0] addr,
    input [31:0] wdata_in,

    // AW
    output [31:0] awaddr,
    output awvalid,
    input awready,

    // W
    output [31:0] wdata,
    output wvalid,
    input wready,

    // B
    output bready,
    input bvalid,
    input [1:0] bresp,

    // AR
    output [31:0] araddr,
    output arvalid,
    input arready,

    // R
    output rready,
    input [31:0] rdata,
    input rvalid,
    input [1:0] rresp
);

    localparam	W_IDLE  = 3'b000,
    		W_AW    = 3'b001,
    		W_W     = 3'b010,
    		W_B     = 3'b011,
    		W_DONE  = 3'b100;

    reg [2:0] w_state;

    localparam	R_IDLE  = 2'b00,
    		R_AR    = 2'b01,
    		R_R     = 2'b10,
    		R_DONE  = 2'b11;

    reg [1:0] r_state;

    // INTERNAL LATCH
    reg [31:0] waddr_latch, wdata_latch, raddr_latch;

    // Registradores internos equivalentes para controle sequencial das saídas
    
    reg		read_done_int,
    		write_done_int,
    		awvalid_int,
    		wvalid_int,
    		bready_int,
    		arvalid_int,
    		rready_int;
    
    reg [31:0]	rdata_out_int,
    		awaddr_int,
    		wdata_int,
    		araddr_int;

    always @(posedge clk) begin
        if(reset) begin
            awvalid_int    <= 1'b0;
            wvalid_int     <= 1'b0;
            bready_int     <= 1'b0;
            write_done_int <= 1'b0;
            awaddr_int     <= 32'b0;
            wdata_int      <= 32'b0;
            w_state        <= W_IDLE;

            // Read channel reset
            arvalid_int    <= 1'b0;
            rready_int     <= 1'b0;
            read_done_int  <= 1'b0;
            araddr_int     <= 32'b0;
            rdata_out_int  <= 32'b0;
            r_state        <= R_IDLE;

            // LATCH
            waddr_latch    <= 32'b0;
            wdata_latch    <= 32'b0;
            raddr_latch    <= 32'b0;
        
        end else begin
            case(w_state)
                // case fsm write
                W_IDLE: begin
                    write_done_int <= 1'b0;
                    if(wr_en) begin
                        waddr_latch <= addr;
                        wdata_latch <= wdata_in;
                        w_state <= W_AW;
                    end
                end
                W_AW: begin
                    awvalid_int <= 1'b1;
                    awaddr_int <= waddr_latch;
                    if(awready) begin
                        awvalid_int <= 1'b0;
                        w_state <= W_W;
                    end
                end
                W_W: begin
                    wvalid_int <= 1'b1;
                    wdata_int <= wdata_latch;
                    if(wready) begin
                        wvalid_int <= 1'b0;
                        bready_int <= 1'b1;
                        w_state <= W_B;
                    end
                end
                W_B: begin
                    if(bvalid) begin
                        bready_int <= 1'b0;
                        w_state <= W_DONE;
                    end
                end
                W_DONE: begin
                    write_done_int <= 1'b1;
                    w_state <= W_IDLE;
                end
                default: w_state <= W_IDLE;
            endcase
            
            // ----READ FSM----
            case(r_state)
                R_IDLE: begin
                    read_done_int <= 1'b0;
                    if(rd_en) begin
                        raddr_latch <= addr;
                        r_state <= R_AR;
                    end
                end
                R_AR: begin
                    araddr_int <= raddr_latch;
                    arvalid_int <= 1'b1;
                    if(arready) begin
                        arvalid_int <= 1'b0;
                        rready_int <= 1'b1;
                        r_state <= R_R;
                    end
                end
                R_R: begin
                    if(rvalid) begin
                        rdata_out_int <= rdata; // Envia para saída
                        rready_int <= 1'b0;
                        r_state <= R_DONE; 
                    end
                end
                R_DONE: begin
                    read_done_int <= 1'b1;
                    r_state <= R_IDLE;
                end
                default: r_state <= R_IDLE;
            endcase
        end
    end
    
    assign {rdata_out, read_done, write_done, awaddr, awvalid, wdata, wvalid, bready, araddr, arvalid, rready} = {rdata_out_int, read_done_int, write_done_int, awaddr_int, awvalid_int, wdata_int, wvalid_int, bready_int, araddr_int, arvalid_int, rready_int};

endmodule
