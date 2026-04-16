`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Zeynettin Ister
// 
// Module Name: addsub
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Adds or subtracts registers depending on sel bit
// 
//////////////////////////////////////////////////////////////////////////////////

module addsub(
    input [7:0] A,
    input [7:0] B,
    input sel,
    output reg [7:0] out
    );
    
always @(*)
begin
case (sel)
1'b0: out = A + B;
1'b1: out = A - B;
endcase
end
    
endmodule
