`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2026 09:42:12 AM
// Design Name: 
// Module Name: reg_a
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


module reg_a(
    input clk,
    input rst,
    input load,
    input [7:0] bus,
    output [7:0] out
);

reg [7:0] a_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        a_reg <= 8'b0;
    end else begin
        if (load) begin
            a_reg <= bus;
        end
    end
end

assign out = a_reg;

endmodule