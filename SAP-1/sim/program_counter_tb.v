`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Kent Hong
// 
// Module Name: program_counter_tb
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Test bench for Program Counter Module
// 
//////////////////////////////////////////////////////////////////////////////////

module program_counter_tb();

reg clk_tb, rst_tb, inc_tb;
wire [7:0] pc_out_tb;

integer i;

// Instantiate UUT for Program Counter TB
program_counter uut(.clk(clk_tb), .rst(rst_tb), .inc(inc_tb), .pc_out(pc_out_tb));

localparam PERIOD = 10;
localparam HALF_PERIOD = 5;

// Generate Clock
initial begin
    clk_tb = 0;
    forever #HALF_PERIOD clk_tb = ~clk_tb;
end

// Start testbench
initial begin
    // Start Program Counter at 0
    rst_tb = 1;
    inc_tb = 0;
    #PERIOD;
    
    // Case 1: rst_tb = 0, inc_tb = 0
    rst_tb = 0;
    inc_tb = 0;
    for (i = 0; i < 16; i = i + 1) begin
        #PERIOD;
    end
    
    // Case 2: rst_tb = 0, inc_tb = 1
    rst_tb = 0;
    inc_tb = 1;
    for (i = 0; i < 16; i = i + 1) begin
        #PERIOD;
    end
    
    // Case 3: rst_tb = 1, inc_tb = 0
    rst_tb = 1;
    inc_tb = 0;
    for (i = 0; i < 16; i = i + 1) begin
        #PERIOD;
    end
    
    // Case 4: rst_tb = 1, inc_tb = 1
    rst_tb = 1;
    inc_tb = 1;
    for (i = 0; i < 16; i = i + 1) begin
        #PERIOD;
    end
    
    $finish;
end

endmodule
