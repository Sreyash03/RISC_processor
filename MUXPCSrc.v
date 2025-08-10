`timescale 1ns / 1ps

module MUXPCSrc(
input PCSrc, 
input [31:0] UpdatedPC, EX_MEM_PC,
output [31:0]SelectedPC);

assign SelectedPC= PCSrc ? EX_MEM_PC : UpdatedPC;

endmodule
