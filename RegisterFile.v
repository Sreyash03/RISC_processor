`timescale 1ns / 1ps

module RegisterFile(
input Clk, EnRW,
input [3:0] WN, RN1, RN2, 
input [31:0] WD, 
output[31:0] RD1,RD2
);

reg [31:0] Registers [0:15];

always@(negedge Clk)
begin
    if(EnRW)
        Registers[WN]<=WD;
end

assign RD1= Registers[RN1];
assign RD2= Registers[RN2];

endmodule
