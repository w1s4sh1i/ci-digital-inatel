
module ram_true_dual_port_single_clock_tb;

  // Parameters
  localparam  DATA_WIDTH = 8;
  			  ADDR_WIDTH = 6;
  			  DELAY = 10;

  //Ports
  reg [DATA_WIDTH-1 : 0] data_a,data_b;
  reg [ADDR_WIDTH-1 : 0] addr_a,addr_b;
  reg we_a, we_b, clk_a, clk_b,
  wire [(DATA_WIDTH-1):0] q_a,q_b;

  reg [3:0] radom_num_0_to_7; 

	true_dual_port_ram_single_clock 
	#(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) UUT (
        .data_a(data_a),
        .data_b(data_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .we_a(we_a),
        .we_b(we_b),
        .clk_a(clk_a),
        .clk_b(clk_b),
        .q_a(q_a),
        .q_b(q_b)
    );

	// dump, display and monitor
	
	always #(DELAY/2)  clk = ! clk ;

	integer i; 
	integer seed1,seed2,seed3;

	always @(posedge clk) begin
	  seed1 = $time;
	  seed2 = $time + 10; 
	  seed3 = $time + 20;     
	end

	initial begin
		we_a <= 1;  
		we_b <= 1;
		clk <= 0;
		
		$display("---Writing data in a---");

		for (i = 0; i < (2**ADDR_WIDTH); i = i + 1 )
		begin
		  @(posedge clk);
		  radom_num_0_to_7 <= $random(seed3); 
		  addr_a = i; 
		  data_a = $random(seed1); 
		  addr_b = i;
		  data_b = $random(seed2);        
		  if (radom_num_0_to_7 < 2) begin
			  $display("At time %t written data: %b to adress: %b with adress. With A ",$time,data_b, addr_a);
		  end else if (radom_num_0_to_7 < 4) begin
			  $display("At time %t written data: %b to adress: %b with adress. With B ",$time,data_b, addr_b);
		  end else begin
			  $display("----------------------------");
			  $display("At time %t written data: %b to adress: %b with adress. With A ",$time,data_b, addr_a);
			  $display("At time %t written data: %b to adress: %b with adress. With B ",$time,data_b, addr_b);
			  $display("----------------------------");
		  end
		  #5;
		end

		#10;
		we_a <= 0;
		we_b <= 0;
		i <= 0;


		$display("---Reading data---");
		for (i = 0; i < (2**ADDR_WIDTH); i = i + 1 )
		begin
		  radom_num_0_to_7 <= $random(seed3); 
		  addr_a = i; 
		  addr_b = i;

		  @(posedge clk);
		  if (radom_num_0_to_7 < 2) begin
			  $display("At time %t Read data: %b from adress: %b with adress. With A ",$time,q_a, addr_a);
		  end else if (radom_num_0_to_7 < 4) begin
			  $display("At time %t Read data: %b from adress: %b with adress. With B ",$time,q_b, addr_b);
		  end else begin
			  $display("----------------------------");
			  $display("At time %t Read data: %b from adress: %b with adress. With A ",$time,q_a, addr_a);
			  $display("At time %t Read data: %b from adress: %b with adress. With B ",$time,q_b, addr_b);
			  $display("----------------------------");
		  end
		  #5;
		end

		$finish;

	end

endmodule
