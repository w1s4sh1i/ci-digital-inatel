`timescale 1ns / 1ps

// [ ] Parametrizar entradas;
module axi4_lite_system_top (
    
    input clk,
    input reset,
    input wr_en,
    input rd_en,
    input [31:0] addr, wdata_in,
    
    output [31:0] rdata_out,
    output read_done, write_done
);

	// AXI-Lite Interconnect signals
	
	wire	awvalid, awready,
		arvalid, arready,
		rvalid, rready,
		wvalid, wready,
		bvalid, bready;
	wire [1:0] bresp, rresp;
	wire [31:0]	awaddr,
			wdata,
			araddr,
			rdata;

    axi4_lite_master UUT_master (
        
        .clk(clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .addr(addr),
        .wdata_in(wdata_in),
        
        //  
        .rdata_out(rdata_out),
        .read_done(read_done),
        .write_done(write_done),
        
        .awvalid(awvalid),
        .awaddr(awaddr),
        .awready(awready),
        .wvalid(wvalid),
        .wdata(wdata),
        .wready(wready),
        .bvalid(bvalid),
        .bresp(bresp),
        .bready(bready),
        .arvalid(arvalid),
        .araddr(araddr),
        .arready(arready),
        .rready(rready),
        .rdata(rdata),
        .rvalid(rvalid),
        .rresp(rresp)
    );

    axi4_lite_subordinate UUT_subordinate (
        .clk(clk),
        .reset(reset),
        .awvalid(awvalid),
        .awaddr(awaddr),
        .awready(awready),
        .wvalid(wvalid),
        .wdata(wdata),
        .wready(wready),
        .bvalid(bvalid),
        .bresp(bresp),
        .bready(bready),
        .arvalid(arvalid),
        .araddr(araddr),
        .arready(arready),
        .rdata(rdata),
        .rvalid(rvalid),
        .rresp(rresp),
        .rready(rready)
    );

endmodule
