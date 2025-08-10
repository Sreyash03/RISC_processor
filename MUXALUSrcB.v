`timescale 1ns / 1ps


module MUXALUSrcB(
input ALUSrcB,
input [31:0] ID_EX_RD2, ID_EX_SgnIMM, 
output [31:0] ALUSelB
);

assign ALUSelB = ALUSrcB ? ID_EX_RD2 : ID_EX_SgnIMM;

endmodule
