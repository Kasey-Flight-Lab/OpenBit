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


integer i;
integer j;
integer count;
reg [7:0] test;


addsub uut(.A(A_tb), .B(B_tb), .sel(sel_tb), .out(out_tb));


initial begin
 

    count = 0;
    sel_tb = 0;
    for (i = 0; i < 256; i=i+1)
    begin
        for (j = 0; j < 256; j=j+1)
        begin
            A_tb = i;
            B_tb = j;
            #1;
            test = A_tb+B_tb;
            if (out_tb != test)
                $display ("ERROR - MISMATCH AT sel_tb=%b A_tb=%h B_tb = %h test = %h out_tb = %h", 
                sel_tb, A_tb, B_tb, test, out_tb);
            else
                count = count + 1;
            if (count == 100)
            begin
                count = 0;
                $display ("100 CASES PASS");
            end
       
        end
        
    end
    
    count = 0;
    sel_tb = 1;
    for (i = 0; i < 256; i=i+1)
    begin
        for (j = 0; j < 256; j=j+1)
        begin
            A_tb = i;
            B_tb = j;
            #1;
            test = A_tb-B_tb;
            if (out_tb !== test)
                $display ("ERROR - MISMATCH AT sel_tb=%b A_tb=%h B_tb = %h test = %h out_tb = %h", 
                sel_tb, A_tb, B_tb, test, out_tb);
            else
                count = count + 1;
            if (count == 100)
            begin
                count = 0;
                $display ("100 CASES PASS");
            end
       
        end
        
    end
    $finish;
end

endmodule