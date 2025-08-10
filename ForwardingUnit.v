`timescale 1ns / 1ps

module ForwardingUnit(
input ID_EX_MW, EX_MEM_EnRW, MEM_WB_EnRW,
input [3:0] EX_MEM_WN, MEM_WB_WN, ID_EX_RN1, ID_EX_RN2,
output reg StoreHazard,
output reg [1:0] ForwardA, ForwardB
);

always@(*)
begin
    if( EX_MEM_EnRW & (ID_EX_RN1 == EX_MEM_WN) & (EX_MEM_WN != 4'b0))
        ForwardA <= 2'b10;
    else if(MEM_WB_EnRW & (ID_EX_RN1 == MEM_WB_WN) & (MEM_WB_WN != 4'b0))
        ForwardA <= 2'b01;
    else
        ForwardA <= 2'b00;
        
    if(ID_EX_MW & (ID_EX_RN2 == EX_MEM_WN))
        begin
        ForwardB<=2'b00;
        StoreHazard<=1;
        end
    else if(EX_MEM_EnRW & (ID_EX_RN2 == EX_MEM_WN) & ((EX_MEM_WN != 4'b0)))
        begin
        ForwardB <= 2'b10;
        StoreHazard<=0;
        end
    else if(MEM_WB_EnRW & (ID_EX_RN2 == MEM_WB_WN) & (MEM_WB_WN != 4'b0))
        begin
        ForwardB <= 2'b01;
        StoreHazard<=0;
        end
    else
        begin
        ForwardB <= 2'b00;
        StoreHazard<=0;
        end
end
endmodule
