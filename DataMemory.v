`timescale 1ns / 1ps

module DataMemory(
input [31:0] Address, WriteData,
input MemRead, MemWrite,
output reg [31:0]ReadData
);

reg [7:0] DataMem [0:15];

always@(*)
begin
if(MemRead)
    ReadData = {DataMem[Address],DataMem[Address+1],DataMem[Address+2],DataMem[Address+3]};
if(MemWrite)
    {DataMem[Address],DataMem[Address+1],DataMem[Address+2],DataMem[Address+3]}<=WriteData;
end

endmodule
