`timescale 1ns / 1ps

module Adder(
input [31:0]PC, 
output [31:0] UpdatedPC
);

assign UpdatedPC = PC+4;

endmodule
