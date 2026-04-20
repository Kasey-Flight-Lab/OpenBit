`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Zeynettin Ister
// 
// Module Name: bus_tb
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: An 8 bit data bus that sends data between other modules by taking in
// module inputs and outputing them depending on logic sent from the controller module
//////////////////////////////////////////////////////////////////////////////////


module bus_tb();
reg [7:0] pc_outtb;
reg [7:0] mem_outtb;
reg [7:0] ir_outtb;
reg [7:0] a_outtb;
reg [7:0] adder_outtb;

reg PC_ENtb;
reg MEM_ENtb;
reg IR_ENtb;
reg A_ENtb;
reg ADDER_ENtb;

wire [7:0] bus;

bus uut(.bus(bus), .pc_out(pc_outtb), .mem_out(mem_outtb), .ir_out(ir_outtb), .a_out(a_outtb), .adder_out(adder_outtb), .PC_EN(PC_ENtb), .MEM_EN(MEM_ENtb), .IR_EN(IR_ENtb), .A_EN(A_ENtb), .ADDER_EN(ADDER_ENtb));

initial begin
    //Test conditions
    //Not necessarily pertaining to what outputs would look like - just showing functionality
    pc_outtb = 8'b10000000;
    mem_outtb = 8'b01000000;
    ir_outtb = 8'b00100000;
    a_outtb = 8'b00010000;
    adder_outtb = 8'b00001000;
        
    //No drive case - expected output: 0
    PC_ENtb = 0;
    MEM_ENtb = 0;
    IR_ENtb = 0;
    A_ENtb = 0;
    ADDER_ENtb = 0;
    #10; 
    // Multiple drive case - expected output: high Z
    PC_ENtb = 1;
    MEM_ENtb = 1;
    #10;
    //Single drive case - expected output: 8'b1000...
    MEM_ENtb = 0;
    #10;
    //Single drive case - expected output 8'b0100...
     PC_ENtb = 0;
    MEM_ENtb = 1;
    #10;

    //Single drive case - expected output: 8'b00100...
    MEM_ENtb = 0;
    IR_ENtb = 1;
    #10;

    //Single drive case - expected output: 8'b00010..
    IR_ENtb = 0;
    A_ENtb = 1;
    #10;

    //Single drive case - expected output: 8'b00001000
    A_ENtb = 0;
    ADDER_ENtb = 1;
    #10;

    //Return to no drive case - expected output: 0
    ADDER_ENtb = 0;
    #10;

    $finish;
end
endmodule