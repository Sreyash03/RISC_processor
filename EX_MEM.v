`timescale 1ns / 1ps

module EX_MEM(
input Clk, 
input ID_EX_MReg, ID_EX_EnRW, ID_EX_MW, ID_EX_MR, 
input [3:0] ID_EX_WN, 
input [31:0] ALUResult, ID_EX_PC, ID_EX_RD2, 
output reg  EX_MEM_MReg, EX_MEM_EnRW, EX_MEM_MW, EX_MEM_MR, 
output reg [3:0] EX_MEM_WN, 
output reg [31:0] EX_MEM_ALUResult, EX_MEM_PC, EX_MEM_RD2
);

always@(posedge Clk)
begin
    EX_MEM_MReg<=ID_EX_MReg;
    EX_MEM_EnRW<=ID_EX_EnRW;
    EX_MEM_MW<=ID_EX_MW;
    EX_MEM_MR<=ID_EX_MR;
    EX_MEM_WN<=ID_EX_WN;
    EX_MEM_ALUResult<=ALUResult;
    EX_MEM_PC<=ID_EX_PC;
    EX_MEM_RD2<=ID_EX_RD2;
end
endmodule
