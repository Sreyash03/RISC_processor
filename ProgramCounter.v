`timescale 1ns / 1ps

module ProgramCounter(
input Reset,PCWrite, Clk,
input [31:0] SelectedPC,
output reg [31:0] PC
);

always@(posedge Clk)
begin
    if(Reset)
        PC<=32'd0;
    else if(PCWrite)
        PC<=PC;
    else
        PC<=SelectedPC;
end
endmodule