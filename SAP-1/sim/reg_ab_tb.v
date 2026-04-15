`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2026 01:06:42 PM
// Design Name: 
// Module Name: reg_ab_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_ab_tb;

reg clk;
reg rst;
reg load_a;
reg load_b;
reg [7:0] bus;

wire [7:0] out_a;
wire [7:0] out_b;

// instantiate Register A
reg_a A (
    .clk(clk),
    .rst(rst),
    .load(load_a),
    .bus(bus),
    .out(out_a)
);

// instantiate Register B
reg_b B (
    .clk(clk),
    .rst(rst),
    .load(load_b),
    .bus(bus),
    .out(out_b)
);

// clock generation
always begin
    #5 clk = ~clk;
end

initial begin
    // initialize
    clk = 0;
    rst = 1;
    load_a = 0;
    load_b = 0;
    bus = 8'b00000000;

    #10;
    rst = 0;

    // load value into A
    bus = 8'b10101010;
    load_a = 1;
    #10;
    load_a = 0;

    // load value into B
    bus = 8'b11001100;
    load_b = 1;
    #10;
    load_b = 0;

    // change bus but don't load
    bus = 8'b11111111;
    #10;

    // load both registers
    load_a = 1;
    load_b = 1;
    #10;
    load_a = 0;
    load_b = 0;

    // reset again
    rst = 1;
    #10;
    rst = 0;

    #20;
    $stop;
end

endmodule
