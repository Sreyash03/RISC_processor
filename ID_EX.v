`timescale 1ns / 1ps

module ID_EX(input Clk, ST, ALUSrcB, MReg, EnRW, MR, MW, 
input [1:0] ALUOp, 
input [3:0] WN, RN1, RN2,
input [31:0] RD1, RD2, IF_ID_PC, SgnIMM, 
output reg ID_EX_PCSrc, ID_EX_ALUSrcB, ID_EX_MReg, ID_EX_EnRW, ID_EX_MR, ID_EX_MW, 
output reg [1:0] ID_EX_ALUOp, 
output reg [3:0] ID_EX_WN, ID_EX_RN1, ID_EX_RN2, 
output reg [31:0] ID_EX_RD1, ID_EX_RD2, ID_EX_PC, ID_EX_SgnIMM
);

always@(posedge Clk)
begin
    if(ST)
    begin
    ID_EX_ALUSrcB<=1'b0;
    ID_EX_MReg<=1'b0;
    ID_EX_EnRW<=1'b0;
    ID_EX_MR<=1'b0;
    ID_EX_MW<=1'b0;
    ID_EX_ALUOp<=2'b0;
    ID_EX_WN<=4'b0;
    ID_EX_RD1<=32'b0;
    ID_EX_RD2<=32'b0;
    ID_EX_PC<=32'b0;
    ID_EX_SgnIMM<=32'b0;
    ID_EX_RN1<=4'b0;
    ID_EX_RN2<=4'b0;
    end
    
    //ID_EX_PCSrc<=PCSrc;
    else 
    begin
    ID_EX_ALUSrcB<=ALUSrcB;
    ID_EX_MReg<=MReg;
    ID_EX_EnRW<=EnRW;
    ID_EX_MR<=MR;
    ID_EX_MW<=MW;
    ID_EX_ALUOp<=ALUOp;
    ID_EX_WN<=WN;
    ID_EX_RD1<=RD1;
    ID_EX_RD2<=RD2;
    ID_EX_PC<=IF_ID_PC;
    ID_EX_SgnIMM<=SgnIMM;
    ID_EX_RN1<=RN1;
    ID_EX_RN2<=RN2;
    end
end

endmodule
