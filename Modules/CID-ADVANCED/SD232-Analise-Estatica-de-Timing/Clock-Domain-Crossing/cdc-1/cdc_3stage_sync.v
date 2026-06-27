`timescale 1ns / 1ps

module cdc_3stage_sync #(
    parameter WIDTH = 1 
)(

    input               src_clk, src_arstn,
    input   [WIDTH-1:0] src_data,
    input               dest_clk, dest_arstn,
    output  [WIDTH-1:0] dest_data
);

    reg [WIDTH-1:0] ff_src;

    reg [WIDTH-1:0] ff_sync_chain1;
    reg [WIDTH-1:0] ff_sync_chain2;
    
    // always_ff
    always @(posedge src_clk or negedge src_arstn) begin
        if (!src_arstn) ff_src <= {WIDTH{1'b0}};
        else ff_src <= src_data;
    end

    always @(posedge dest_clk or negedge dest_arstn) begin
        if (!dest_arstn) begin
            ff_sync_chain1 <= {WIDTH{1'b0}};
            ff_sync_chain2 <= {WIDTH{1'b0}};
        end else begin
            ff_sync_chain1 <= ff_src;
            ff_sync_chain2 <= ff_sync_chain1;
        end
    end
    
    assign dest_data = (dest_arstn) ? ff_sync_chain2 : {WIDTH{1'b0}};

endmodule
