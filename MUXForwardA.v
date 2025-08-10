`timescale 1ns / 1ps

module MUXForwardA(
input [1:0] ForwardA, 
input [31:0] EX_MEM_ALUResult, WD, ID_EX_RD1, 
output reg [31:0] ALUInA
);

always@(*)
begin
    case(ForwardA)
        2'b00 : ALUInA <= ID_EX_RD1;
        2'b01 : ALUInA <= WD;
        2'b10 : ALUInA <= EX_MEM_ALUResult;
        default : ALUInA <=32'b0;
    endcase
end
endmodule
