`timescale 1ns / 1ps

module MUXRegWriteSrc(
input MEM_WB_MReg,
input [31:0] MEM_WB_ALUResult, MEM_WB_ReadData,
output [31:0] WD
);

assign WD= MEM_WB_MReg ? MEM_WB_ReadData : MEM_WB_ALUResult;

endmodule
