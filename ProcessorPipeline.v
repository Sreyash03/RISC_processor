`timescale 1ns / 1ps

module ProcessorPipeline(
input Clk,Reset
);

wire StoreHazard, ST, IFIDWrite, PCWrite, PCSrc, EnIM, EnRW, MEM_WB_EnRW, ALUSrcB, MReg, MR, MW; 
wire ID_EX_ALUSrcB, ID_EX_MReg, ID_EX_EnRW, ID_EX_MR, ID_EX_MW, EX_MEM_MReg, EX_MEM_EnRW, EX_MEM_MW, EX_MEM_MR, MEM_WB_MReg, ID_EX_Write;
wire [1:0] ALUOp, ID_EX_ALUOp, ALUControlSignal, ForwardA, ForwardB;
wire [3:0] IF_ID_OpCode, IF_ID_WN, IF_ID_RN1, IF_ID_RN2, MEM_WB_WN, WN, ID_EX_WN, EX_MEM_WN, ID_EX_RN1, ID_EX_RN2;
wire [15:0] IF_ID_IMM;
wire [31:0] PC,UpdatedPC,SelectedPC,Instruction,IF_ID_PC,WD,RD1,RD2,SgnIMM,ID_EX_RD1,ID_EX_RD2, ID_EX_PC,ID_EX_SgnIMM;
wire [31:0] ALUSelB,ALUResult,EX_MEM_ALUResult,EX_MEM_PC,EX_MEM_RD2,ReadData,MEM_WB_PC,MEM_WB_ALUResult,MEM_WB_ReadData,ALUInA,ALUInB,WriteData;

ProgramCounter pc(
    .Reset(Reset),
    .PCWrite(PCWrite),
    .Clk(Clk),
    .SelectedPC(SelectedPC),
    .PC(PC)
);

Adder adder(
    .PC(PC),
    .UpdatedPC(UpdatedPC)
);

MUXPCSrc muxpcsrc(
    .PCSrc(PCSrc),
    .UpdatedPC(UpdatedPC),
    .EX_MEM_PC(EX_MEM_PC),
    .SelectedPC(SelectedPC)
);

InstructionMemory im(
    .EnIM(EnIM),
    .ADDR(PC),
    .RD(Instruction)
);

IF_ID ifid(
    .Clk(Clk),
    .IFIDWrite(IFIDWrite),
    .Instruction(Instruction),
    .UpdatedPC(UpdatedPC),
    .IF_ID_OpCode(IF_ID_OpCode),
    .IF_ID_WN(IF_ID_WN), 
    .IF_ID_RN1(IF_ID_RN1),
    .IF_ID_RN2(IF_ID_RN2),
    .IF_ID_IMM(IF_ID_IMM),
    .IF_ID_PC(IF_ID_PC)
);

RegisterFile regfile(
    .Clk(Clk),
    .EnRW(MEM_WB_EnRW),
    .WN(MEM_WB_WN),
    .RN1(IF_ID_RN1),
    .RN2(IF_ID_RN2),
    .WD(WD),
    .RD1(RD1),
    .RD2(RD2)
);

MainControl mc(
    .Clk(Clk),
    .OpCode(IF_ID_OpCode),
    .PCSrc(PCSrc),
    .EnIM(EnIM),
    .ALUSrcB(ALUSrcB),
    .MReg(MReg),
    .EnRW(EnRW),
    .MR(MR),
    .MW(MW),
    .ALUOp(ALUOp)
);

Extend ex(
    .IMM(IF_ID_IMM),
    .SgnIMM(SgnIMM)
);

ID_EX idex(
    .Clk(Clk),
    .ST(ST),
    .ALUSrcB(ALUSrcB),
    .MReg(MReg),
    .EnRW(EnRW),
    .MR(MR),
    .MW(MW),
    .RN1(IF_ID_RN1),
    .RN2(IF_ID_RN2),
    .WN(IF_ID_WN),
    .RD1(RD1),
    .RD2(RD2),
    .IF_ID_PC(IF_ID_PC),
    .SgnIMM(SgnIMM),
    .ALUOp(ALUOp),
    .ID_EX_ALUSrcB(ID_EX_ALUSrcB),
    .ID_EX_MReg(ID_EX_MReg),
    .ID_EX_EnRW(ID_EX_EnRW),
    .ID_EX_MR(ID_EX_MR),
    .ID_EX_MW(ID_EX_MW),
    .ID_EX_ALUOp(ID_EX_ALUOp), 
    .ID_EX_RN1(ID_EX_RN1),
    .ID_EX_RN2(ID_EX_RN2),
    .ID_EX_WN(ID_EX_WN),
    .ID_EX_RD1(ID_EX_RD1),
    .ID_EX_RD2(ID_EX_RD2),
    .ID_EX_PC(ID_EX_PC),
    .ID_EX_SgnIMM(ID_EX_SgnIMM)
);

ForwardingUnit fu(
    .ID_EX_MW(ID_EX_MW),
    .EX_MEM_EnRW(EX_MEM_EnRW),
    .MEM_WB_EnRW(MEM_WB_EnRW),
    .EX_MEM_WN(EX_MEM_WN),
    .MEM_WB_WN(MEM_WB_WN),
    .ID_EX_RN1(ID_EX_RN1),
    .ID_EX_RN2(ID_EX_RN2),
    .StoreHazard(StoreHazard),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);

Stalling stalling (
    .ID_EX_MR(ID_EX_MR),
    .ID_EX_WN(ID_EX_WN),
    .IF_ID_RN1(IF_ID_RN1),
    .IF_ID_RN2(IF_ID_RN2),
    .ST(ST),
    .IFIDWrite(IFIDWrite),
    .PCWrite(PCWrite)
);

MUXALUSrcB muxalusrcb(
    .ALUSrcB(ID_EX_ALUSrcB),
    .ID_EX_RD2(ID_EX_RD2),
    .ID_EX_SgnIMM(ID_EX_SgnIMM),
    .ALUSelB(ALUSelB)
);

MUXForwardA muxforwarda(
    .ForwardA(ForwardA),
    .EX_MEM_ALUResult(EX_MEM_ALUResult),
    .WD(WD),
    .ID_EX_RD1(ID_EX_RD1),
    .ALUInA(ALUInA)
);

MUXForwardB muxforwardb(
    .ForwardB(ForwardB),
    .EX_MEM_ALUResult(EX_MEM_ALUResult),
    .WD(WD),
    .ALUSelB(ALUSelB),
    .ALUInB(ALUInB)
);

ALUControl alucontrol(
    .ID_EX_ALUOp(ID_EX_ALUOp),
    .ALUControlSignal(ALUControlSignal)
);

ALU alu(
    .ALUInA(ALUInA),
    .ALUInB(ALUInB),
    .ALUControlSignal(ALUControlSignal),
    .ALUResult(ALUResult)
);

EX_MEM exmem(
    .Clk(Clk),
    .ID_EX_MReg(ID_EX_MReg),
    .ID_EX_EnRW(ID_EX_EnRW),
    .ID_EX_MW(ID_EX_MW),
    .ID_EX_MR(ID_EX_MR),
    .ID_EX_WN(ID_EX_WN),
    .ALUResult(ALUResult),
    .ID_EX_PC(ID_EX_PC),
    .ID_EX_RD2(WriteData),
    .EX_MEM_MReg(EX_MEM_MReg),
    .EX_MEM_EnRW(EX_MEM_EnRW),
    .EX_MEM_MW(EX_MEM_MW),
    .EX_MEM_MR(EX_MEM_MR),
    .EX_MEM_WN(EX_MEM_WN),
    .EX_MEM_ALUResult(EX_MEM_ALUResult),
    .EX_MEM_PC(EX_MEM_PC),
    .EX_MEM_RD2(EX_MEM_RD2)
);

MUXWriteDataSrc muxwritedatasrc (
    .StoreHazard(StoreHazard),
    .ID_EX_RD2(ID_EX_RD2),
    .EX_MEM_ALUResult(EX_MEM_ALUResult),
    .WriteData(WriteData)
);

DataMemory dm(
    .Address(EX_MEM_ALUResult),
    .WriteData(EX_MEM_RD2),
    .MemRead(EX_MEM_MR),
    .MemWrite(EX_MEM_MW),
    .ReadData(ReadData)
);

MEM_WB memwb(
    .Clk(Clk),
    .EX_MEM_MReg(EX_MEM_MReg),
    .EX_MEM_EnRW(EX_MEM_EnRW),
    .EX_MEM_WN(EX_MEM_WN),
    .ReadData(ReadData),
    .EX_MEM_ALUResult(EX_MEM_ALUResult),
    .MEM_WB_MReg(MEM_WB_MReg),
    .MEM_WB_EnRW(MEM_WB_EnRW),
    .MEM_WB_WN(MEM_WB_WN),
    .MEM_WB_ALUResult(MEM_WB_ALUResult),
    .MEM_WB_ReadData(MEM_WB_ReadData)
);

MUXRegWriteSrc muxregwritesrc(
    .MEM_WB_MReg(MEM_WB_MReg),
    .MEM_WB_ALUResult(MEM_WB_ALUResult),
    .MEM_WB_ReadData(MEM_WB_ReadData),
    .WD(WD)
);

endmodule
