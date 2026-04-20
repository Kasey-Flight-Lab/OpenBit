`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 03:36:14 PM
// Design Name: 
// Module Name: ir_tb
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


`timescale 1ns/1ps

module ir_tb;

reg clk;
reg rst;
reg load_ir;
reg [7:0] bus;

wire [7:0] out;

// instantiate IR
ir uut (
	.clk(clk),
	.rst(rst),
	.load_ir(load_ir),
	.bus(bus),
	.out(out)
);

// clock generation
always begin
	#5 clk = ~clk;
end

initial begin
	// initialize signals
	clk = 0;
	rst = 1;
	load_ir = 0;
	bus = 8'b00000000;

	#10;
	rst = 0;

	// load first instruction
	bus = 8'b10101010;
	load_ir = 1;
	#10;
	load_ir = 0;

	// change bus, but don't load
	bus = 8'b11001100;
	#10;

	// load new instruction
	load_ir = 1;
	#10;
	load_ir = 0;

	// reset register
	rst = 1;
	#10;
	rst = 0;

	#20;
	$stop;
end

endmodule
