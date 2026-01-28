module stimulus_from_file #(
    parameter FILE_NAME = "stimulus.hex",           // File to read
    parameter DATA_WIDTH = 8,                       // Width of data
    parameter DEPTH = 8                             // Number of memory locations
)(
    input   [$clog2(DEPTH)-1:0] addr,               // Address bus
    output  [DATA_WIDTH-1:0]    data                // Data bus
);
    integer     fd;
    reg         [DATA_WIDTH-1:0] q;
    reg         [DATA_WIDTH-1:0] tmp_ROM [0:DEPTH-1];

    initial begin
        fd = $fopen(FILE_NAME,"r");
        if (!fd) $display("Error to open file: ", FILE_NAME);
        else $readmemh(FILE_NAME, tmp_ROM);
        $fclose(fd);
    end

    always @(*) begin
        q = tmp_ROM[addr];
    end

    assign data = q;
endmodule

module save_result_to_file #(
    parameter FILE_NAME = "result.txt",             // File to save
    parameter RADIX = "bin",                        // Save data radix: bin, dec, hex, oct           
    parameter DATA_WIDTH = 8                        // Width of data
)(
    input                       clk,                // Clock
    input                       enable,             // Enable
    input   [DATA_WIDTH-1:0]    data,               // Data bus
    input                       save,               // Flag to end writing and save file
    output                      complete
);
    integer     fd;
    reg         finished;

    initial begin
        fd = $fopen(FILE_NAME, "wb");
        if (!fd) $display("Error to open file: ", FILE_NAME);
        finished <= 0;
    end

    always @(posedge clk) begin
        if (!finished) begin
            if (enable) begin
                case (RADIX)
                    "bin" :  $fdisplayb(fd, data);  // Displays in binary
                    "dec" :  $fdisplay(fd, data);   // Displays in decimal
                    "hex" :  $fdisplayh(fd, data);  // Displays in hex
                    "oct" :  $fdisplayo(fd, data);  // Displays in octal
                    default: $fdisplay(fd, data);   // Displays in decimal
                endcase
            end 
        end
    end

    always @(negedge clk) begin
        if (save) begin
            $fclose(fd);
            finished <= 1;
        end
    end

    assign complete = finished;
endmodule

module clock_generator #(
    parameter real FREQ_HZ = 100_000_000,           // Default: 100 MHz
    parameter      START_POLARITY = 1               // Default: Start with HIGH (1)
)(
    output clk
);
    localparam real HALF_PERIOD = 1.0 / (2.0 * FREQ_HZ) * 1e9; 
    reg clock;

    initial clock = START_POLARITY;                 // Set initial polarity

    always begin
        #(HALF_PERIOD) clock = ~clock;              // Toggle clock
    end

    assign clk = clock;
endmodule