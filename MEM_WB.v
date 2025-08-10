`timescale 1ns / 1ps

module MEM_WB(
input Clk,
input EX_MEM_MReg, EX_MEM_EnRW,
input [3:0] EX_MEM_WN, 
input [31:0] ReadData, EX_MEM_ALUResult,
output reg MEM_WB_MReg, MEM_WB_EnRW,
output reg [3:0] MEM_WB_WN,
output reg [31:0] MEM_WB_ALUResult, MEM_WB_ReadData
);

always@(posedge Clk)
begin
    MEM_WB_MReg<=EX_MEM_MReg;
    MEM_WB_EnRW<=EX_MEM_EnRW;
    MEM_WB_ReadData<=ReadData;
    MEM_WB_ALUResult<=EX_MEM_ALUResult;
    MEM_WB_WN<=EX_MEM_WN;
end
endmodule
