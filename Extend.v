`timescale 1ns / 1ps

module Extend(
input [15:0]IMM,
output [31:0]SgnIMM
);

assign SgnIMM = {{16{IMM[15]}}, IMM};

endmodule
