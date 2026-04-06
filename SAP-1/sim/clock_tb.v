`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Khoa Nguyen
// 
// Module Name: Clock_tb
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Test bench for clock.v module
// 
//////////////////////////////////////////////////////////////////////////////////

module clock_tb;

    reg hlt_tb;
    reg clk_in_tb;
    wire clk_out_tb;

    clock uut1 (.hlt(hlt_tb), .clk_in(clk_in_tb), .clk_out(clk_out_tb));

    localparam HALF_PERIOD = 5; //Setting constant

    //Clock Signal Generation
    initial begin
        clk_in_tb = 0; //starting from low stage
    end
    
    always #HALF_PERIOD clk_in_tb = ~clk_in_tb;
    
    //Input Signal Generation, aim for 100n run so 100/10 = 10 clock cycles
    initial begin

        //Case 1: Halt instruction off, clk out
        hlt_tb = 0;
        #20;

        //Case 2: Halt instruction on, no clk out
        hlt_tb = 1;
        #20;

        //Case 3: Halt instruction off then on for each 10ns
        hlt_tb = 0;
        #10;
        hlt_tb = 1;
        #10;

        //Case 4: Half instruction off then on for each 5ns
        repeat (2) begin
            hlt_tb = 0;
            #5;
            hlt_tb = 1;
            #5;
        end

        //Case 5: Half instruction off then on for each 2ns
        repeat (5) begin
            hlt_tb = 0;
            #2;
            hlt_tb = 1;
            #2;
        end

        $finish;
    end
endmodule

