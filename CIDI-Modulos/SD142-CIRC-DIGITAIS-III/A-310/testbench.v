/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306 (A-310)
Type: Testbench
Data: febuary, 9 2026
*/

`timescale 1 ns / 1 ps

module testbench;
   
   	localparam	DELAY = 100,
    			real DATA_FREQUENCY = 100e6,      // Clock frequency in Hz
    			real SYS_FREQUENCY = 27e6;

    wire wclk, rclk;    
    
    clock_generator #(DATA_FREQUENCY, 1) CLOCK100M(.clk(wclk));
    clock_generator #(SYS_FREQUENCY, 1) CLOCK27M(.clk(rclk));
    
    /*
    // Specify the VCD file name
		$dumpfile("<task-id>.vcd"); 
		$dumpvars(0, <testbench-id>_tb); 
	*/
	
    always @(posedge wclk) begin
        $display(rclk);
    end

    initial begin
        #DELAY;
        $finish;
    end

endmodule

// Clock module

module clock_generator #(
    parameter real	FREQ_HZ = 100_000_000,           // Default: 100 MHz
    				START_POLARITY = 1               // Default: Start with HIGH (1)
)(
    output clk
);
    
    localparam real HALF_PERIOD = 1.0 / (2.0 * FREQ_HZ) * 1e9; 
    
    reg clock;

	assign clk = clock;
	
    initial clock = START_POLARITY;                 // Set initial polarity

    always begin
        #(HALF_PERIOD) clock = ~clock;              // Toggle clock
    end
    
endmodule

module stimulus_from_file #(

    parameter	FILE_NAME1 = "tsdata1_loss.ts",
    			FILE_NAME2 = "tsdata2_loss.ts",
    			FILE_NAME3 = "tsdata3_loss.ts",
    			FILE_NAME4 = "tsdata4_loss.ts",
    			DATA_WIDTH = 8
    			// DEPTH      = 
)(
    input	clk,
    output	[DATA_WIDTH-1:0] byte_data1, // [DATA_WIDTH-1:0] byte_data [3:0]
    						 byte_data2,
    						 byte_data3,
    						 byte_data4
);
    // output regs
    reg [DATA_WIDTH-1:0] byte_data1_,
                         byte_data2_,
                         byte_data3_,
                         byte_data4_;

    // variables to store file handles
    integer fh1, fh2, fh3, fh4; // [3:0] fh
    
    initial begin
    
        fh1 = $fopen(FILE_NAME1, "rb");
        fh2 = $fopen(FILE_NAME2, "rb");
        fh3 = $fopen(FILE_NAME3, "rb");
        fh4 = $fopen(FILE_NAME4, "rb");

		// for para analisar todas as ações; 
        if (!fh1) begin
            $display("Error to open file: ", FILE_NAME1);
            $finish();
        end else if (!fh2) begin
            $display("Error to open file: ", FILE_NAME2);
            $finish();
        end else if (!fh3) begin
            $display("Error to open file: ", FILE_NAME3);
            $finish();
        end else if (!fh4) begin
            $display("Error to open file: ", FILE_NAME4);
            $finish();
        end else begin
        
            // Keep reading lines until EOF is found
            while (! $feof(fh1)) begin
                @(posedge clk)
                byte_data1_ = $fgetc(fh1);
                $display("Data1: %h", byte_data1);
                byte_data2_ = $fgetc(fh2);
                $display("Data2: %h", byte_data2);
                byte_data3_ = $fgetc(fh3);
                $display("Data3: %h", byte_data3);
                byte_data4_ = $fgetc(fh4);
                $display("Data4: %h", byte_data4);
                $display("EOF: %0d", !$feof(fh1));
            end
        end

        $fclose(fh1);
        $fclose(fh2);
        $fclose(fh3);
        $fclose(fh4);
    end

	// [ ] Utilizar data array: 
    assign byte_data1 = byte_data1_;
    assign byte_data2 = byte_data2_;
    assign byte_data3 = byte_data3_;
    assign byte_data4 = byte_data4_;
    
endmodule
