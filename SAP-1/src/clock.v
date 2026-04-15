`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Khoa Nguyen
// 
// Module Name: Clock
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Manually control clock for the SAP-1
// 
//////////////////////////////////////////////////////////////////////////////////

module clock(
    input hlt, //Halt instruction later for stopping the system
    input clk_in,
    output clk_out
);

assign clk_out = (hlt) ? 1'b0 : clk_in; //Yes, this is tertenary operator of halt instruction reset or not

endmodule