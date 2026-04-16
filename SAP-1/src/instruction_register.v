`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 03:34:37 PM
// Design Name: 
// Module Name: ir
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


module ir(
	input clk,
	input rst,
	input load_ir,
	input [7:0] bus,
	output [7:0] out
);

reg [7:0] ir_reg;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		ir_reg <= 8'b00000000;
	end else begin
		if (load_ir) begin
			ir_reg <= bus;
		end
	end
end

assign out = ir_reg;

endmodule
