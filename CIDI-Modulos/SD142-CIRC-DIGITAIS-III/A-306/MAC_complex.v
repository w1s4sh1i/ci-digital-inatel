module MAC_complex (
    input clk, rst, en,
    input [7:0] reA,reB,imA,imB,
    output [31:0] X,Y
);

    wire signed [15:0] re_product1;
    wire signed [15:0] re_product2;
    wire signed [15:0] im_product1;
    wire signed [15:0] im_product2;

    wire signed [31:0] re_sum; 
    wire signed [31:0] im_sum; 

    reg signed [31:0] re_accumulator;
    reg signed [31:0] im_accumulator;

    assign re_product1 = $signed(reA)*$signed(reB);
    assign re_product2 = ($signed(imA)*$signed(imB)); 
    assign re_sum = re_accumulator + re_product1 - re_product2;
    
    assign im_product1 = $signed(reA)*$signed(imB);
    assign im_product2 = $signed(imA)*$signed(reB);

    assign im_sum = im_accumulator + im_product1 + im_product2; 

    always @(posedge clk) begin
        if (rst) begin
            re_accumulator <= 0; 
            im_accumulator <= 0;
        end else if (en) begin
            re_accumulator <= re_sum; 
            im_accumulator <= im_sum;
        end
    end

    assign X = re_accumulator;
    assign Y = im_accumulator;  

endmodule



module MAC_complex_tb;

  // Parameters

  //Ports
  reg clk;
  reg rst;
  reg en;
  reg [7:0] reA,reB,imA,imB;
  wire [31:0] X,Y;

  integer seed1,seed2,seed3,seed4,i; 

  MAC_complex  MAC_complex_inst (
    .clk(clk),
    .rst(rst),
    .en(en),
    .reA(reA),
    .reB(reB),
    .imA(imA),
    .imB(imB),
    .X(X),
    .Y(Y)
  );

  always @(posedge clk) begin
    seed1 <= $time; 
    seed2 <= $time + 10; 
    seed3 <= $time + 20; 
    seed4 <= $time + 30; 
  end

  always #5  clk = ! clk ;

  initial begin
    clk <= 0;
    rst <= 1; 
    en <= 0; 
    {reA,reB,imA,imB} <= {4'b0}; 
    #5; 

    rst <= 0;
    en <= 1;
    
    for (i = 0; i < (10); i = i + 1 ) begin
        @(posedge clk);
        reA <= $random(seed1) + $random(seed4);
        reB <= $random(seed2) + $random(seed3);
        imA <= $random(seed3);
        imB <= $random(seed4);   
        @(posedge clk);
        $display("(%d + j%d )*(%d +j%d) = (%d + j%d)",reA,imA,reB,imB,X,Y); 
        @(posedge clk);
        rst <= 1; 
        @(posedge clk);
        rst <= 0; 
    end 
    $stop;

  end
endmodule