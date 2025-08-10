`timescale 1ns / 1ps

module Stalling(
input ID_EX_MR,
input [3:0] ID_EX_WN, IF_ID_RN1, IF_ID_RN2,
output reg IFIDWrite, PCWrite, ST
);

always@(*)
begin
if(ID_EX_MR &(ID_EX_WN==IF_ID_RN1 | ID_EX_WN==IF_ID_RN2))
    begin
        ST<=1;
        IFIDWrite<=1;
        PCWrite<=1;
    end
else
    ST<=0;
    IFIDWrite<=0;
    PCWrite<=0;
end

endmodule
