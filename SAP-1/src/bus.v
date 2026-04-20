`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Zeynettin Ister
// 
// Module Name: bus
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: An 8 bit data bus that sends data between other modules by taking in
// module inputs and outputing them depending on logic sent from the controller module
//////////////////////////////////////////////////////////////////////////////////

module bus(
    output reg [7:0] bus,

    input [7:0] pc_out,
    input [7:0] mem_out,
    input [7:0] ir_out,
    input [7:0] a_out,
    input [7:0] adder_out,

    input PC_EN,
    input MEM_EN,
    input IR_EN,
    input A_EN,
    input ADDER_EN
          );

always @(*)
begin

    if ((PC_EN + MEM_EN + IR_EN + A_EN + ADDER_EN) > 1)
    begin
        bus = 8'bzzzzzzzz;
    end
    else if (PC_EN)
    begin
        bus = pc_out;
    end
    else if (MEM_EN)
    begin
        bus = mem_out;
    end
    else if (IR_EN)
    begin
        bus = ir_out;
    end
    else if (A_EN)
    begin
        bus = a_out;
    end
    else if (ADDER_EN)
    begin
        bus = adder_out;
    end
    else
    begin
        bus = 8'b00000000;
    end
end
endmodule