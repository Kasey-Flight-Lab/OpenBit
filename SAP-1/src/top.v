`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KASEY FLIGHT LAB
// Engineer: Khoa Nguyen
// 
// Module Name: top
// Project Name: OpenBit
// Target Devices: Nexys A7-100T
// Description: top file for logic of FPGA board to generate bitstream
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input CLK100MHZ,
    input CPU_RESETN,
    input BTNC,
    input [15:0] SW,
    output [15:0] LED
);

wire rst = ~CPU_RESETN;

// 1 Hz slow clock: one full CPU cycle per second
reg [25:0] clk_count = 0;
reg slow_clk = 0;

always @(posedge CLK100MHZ or posedge rst) begin
    if (rst) begin
        clk_count <= 0;
        slow_clk <= 0;
    end else begin
        if (clk_count == 49_999_999) begin
            clk_count <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            clk_count <= clk_count + 1;
        end
    end
end

wire clk;
wire hlt;

clock clock_unit(
    .hlt(hlt),
    .clk_in(slow_clk),
    .clk_out(clk)
);

wire pc_en;
wire mem_en;
wire ir_en;
wire a_en;
wire adder_en;

wire mar_load;
wire a_load;
wire b_load;
wire pc_inc;
wire ir_load;
wire adder_sub;

wire [7:0] data_bus;
wire [7:0] adder_out;
wire [7:0] a_out;
wire [7:0] b_out;
wire [7:0] ir_out;
wire [7:0] mem_out;
wire [7:0] pc_out;

bus bus_unit(
    .bus(data_bus),
    .pc_out(pc_out),
    .mem_out(mem_out),
    .ir_out(ir_out),
    .a_out(a_out),
    .adder_out(adder_out),
    .PC_EN(pc_en),
    .MEM_EN(mem_en),
    .IR_EN(ir_en),
    .A_EN(a_en),
    .ADDER_EN(adder_en)
);

program_counter pc_unit(
    .clk(clk),
    .rst(rst),
    .inc(pc_inc),
    .pc_out(pc_out)
);

memory mem_unit(
    .clk(clk),
    .rst(rst),
    .load(mar_load),
    .bus(data_bus),
    .out(mem_out)
);

reg_a reg_a_unit(
    .clk(clk),
    .rst(rst),
    .load(a_load),
    .bus(data_bus),
    .out(a_out)
);

reg_b reg_b_unit(
    .clk(clk),
    .rst(rst),
    .load(b_load),
    .bus(data_bus),
    .out(b_out)
);

addsub addsub_unit(
    .A(a_out),
    .B(b_out),
    .sel(adder_sub),
    .out(adder_out)
);

ir ir_unit(
    .clk(clk),
    .rst(rst),
    .load_ir(ir_load),
    .bus(data_bus),
    .out(ir_out)
);

controller controller_unit(
    .clk(clk),
    .rst(rst),
    .opcode(ir_out[7:4]),
    .out({
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

assign LED[7:0]  = a_out;
assign LED[15:8] = b_out;

endmodule