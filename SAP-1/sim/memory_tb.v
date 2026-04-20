`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Kent Hong
// 
// Module Name: memory_tb
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: Test bench for memory
// 
//////////////////////////////////////////////////////////////////////////////////

module memory_tb();

    reg clk;
    reg rst;
    reg load;
    reg [7:0] bus;
    wire [7:0] out;

    integer i;

    memory uut (.clk(clk), .rst(rst), .load(load), .bus(bus), .out(out));

    always #5 clk = ~clk;

    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            uut.ram[i] = i * 8'h11;
        end
    end

    initial begin
        clk  = 0;
        rst  = 0;
        load = 0;
        bus  = 8'h00;

        rst = 1;
        #10;
        rst = 0;
        #10;

        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            bus  = i[7:0];
            load = 1;

            @(posedge clk);
            #1;
            load = 0;

            #9;
        end

        $finish;
    end

endmodule