`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Kent Hong
// 
// Module Name: program_counter
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Stores the memory address of next instruction to be executed.
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(
    input clk,
	input rst,
	input inc,
	output[7:0] out
);

reg[3:0] pc;

always @(posedge clk, posedge rst) begin
	if (rst) begin
		pc <= 4'b0;
	end else if (inc) begin
		pc <= pc + 1;
	end
end

assign out = pc;

endmodule