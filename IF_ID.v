`timescale 1ns / 1ps

module IF_ID(input Clk,
input IFIDWrite, 
input [31:0] Instruction, UpdatedPC,
output reg [3:0] IF_ID_OpCode, IF_ID_WN, IF_ID_RN1, IF_ID_RN2,
output reg [15:0] IF_ID_IMM, 
output reg [31:0] IF_ID_PC
);

always@(posedge Clk)
begin
    if(IFIDWrite)
    begin
        IF_ID_OpCode<=IF_ID_OpCode;
        IF_ID_WN<=IF_ID_WN;
        IF_ID_RN1<=IF_ID_RN1;
        IF_ID_RN2<=IF_ID_RN2;
        IF_ID_IMM<=IF_ID_IMM;  
        IF_ID_PC<=IF_ID_PC;
    end
    else
    begin
        IF_ID_OpCode<=Instruction[31:28];
        IF_ID_WN<=Instruction[27:24];
        IF_ID_RN1<=Instruction[23:20];
        IF_ID_RN2<=Instruction[19:16];
        IF_ID_IMM<=Instruction[15:0]; 
        IF_ID_PC<=UpdatedPC;
    end
end
endmodule
