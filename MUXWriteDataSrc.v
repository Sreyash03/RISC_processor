`timescale 1ns / 1ps

module MUXWriteDataSrc(
input StoreHazard,
input [31:0] ID_EX_RD2,
input [31:0] EX_MEM_ALUResult,
output [31:0] WriteData
);

begin
    assign WriteData = StoreHazard ? EX_MEM_ALUResult : ID_EX_RD2;
end
endmodule
