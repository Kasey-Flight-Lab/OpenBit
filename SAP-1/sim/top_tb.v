`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Kasey Flight Lab
// Engineer: Khoa A. nguyen
// 
// Create Date: 4/20/2026 3:30PM
// Design Name: top test bench
// Module Name: top_tb
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


module top_tb();

//DECLARATION
//Enable Signal
wire pc_en;
wire mem_en;
wire ir_en;
wire a_en;
wire adder_en;
wire[4:0] bus_en = {pc_en, mem_en, ir_en, a_en, adder_en};

//Output
wire[7:0] adder_out;
wire[7:0] a_out;
wire[7:0] ir_out;
wire[7:0] mem_out;
wire[7:0] pc_out;

reg[7:0] bus;

wire clk;
wire hlt;
wire mar_load;
wire a_load;
wire pc_inc;

wire b_load;
wire[7:0] b_out;
reg rst;
wire ir_load;

wire adder_sub;
initial begin
	rst = 1;
	#1 rst = 0;
end

always @(*) begin
	case (bus_en)
		5'b00001: bus = adder_out;
		5'b00010: bus = a_out;
		5'b00100: bus = ir_out;
		5'b01000: bus = mem_out;
		5'b10000: bus = pc_out;
		default: bus = 8'b0;
	endcase
end

reg clk_in = 0;
integer i;
initial begin
	for (i = 0; i < 128; i = i+1) begin
		#1 clk_in = ~clk_in;
	end
end

clock clock(.hlt(hlt), .clk_in(clk_in), .clk_out(clk));
program_counter program_counter(.clk(clk), .rst(rst), .inc(pc_inc), .pc_out(pc_out));
memory mem(.clk(clk), .rst(rst), .load(mar_load), .bus(bus),.out(mem_out));
reg_a reg_a(.clk(clk), .rst(rst), .load(a_load), .bus(bus), .out(a_out));
reg_b reg_b(.clk(clk), .rst(rst), .load(b_load), .bus(bus), .out(b_out));
addsub addsub(.A(a_out), .B(b_out), .sel(adder_sub), .out(adder_out));
ir ir(.clk(clk), .rst(rst), .load_ir(ir_load), .bus(bus), .out(ir_out));
controller controller(.clk(clk), .rst(rst), .opcode(ir_out[7:4]),
	.out(
	{
		adder_en,
        adder_sub,
        b_load,
        a_en,
        a_load,
        ir_en,
        ir_load,
        mem_en,
        mar_load,
        pc_en,
        pc_inc,
        hlt
	})
);

endmodule