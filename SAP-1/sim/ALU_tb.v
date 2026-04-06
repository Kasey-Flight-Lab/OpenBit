`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Zeynettin Ister
// 
// Module Name: addsub_tb
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Adds or subtracts registers depending on sel bit
// 
//////////////////////////////////////////////////////////////////////////////////

module addsub_tb();
reg [7:0] A_tb;
reg [7:0] B_tb;
reg sel_tb;
wire [7:0] out_tb;

addsub uut(.A(A_tb), .B(B_tb), .sel(sel_tb), .out(out_tb));


initial begin

//10 + 10 = 20
sel_tb = 0;
A_tb = 10;
B_tb = 10;
#50;

//11 + 255 = 10
A_tb = 11;
B_tb = 255;
#50;

//100 + 100 = 200
A_tb = 100;
B_tb = 100;
#50;

//255 - 255 = 0
sel_tb = 1;
A_tb = 255;
B_tb = 255;
#50;

//0 - 1 = 255 (EXPECTED)
A_tb = 0;
B_tb = 1;
#50;

//255 - 128 = 127
A_tb = 255;
B_tb = 128;
#50;

end

endmodule