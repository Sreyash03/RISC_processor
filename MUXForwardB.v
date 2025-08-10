`timescale 1ns / 1ps

module MUXForwardB(
input [1:0]ForwardB, 
input [31:0] EX_MEM_ALUResult, WD, ALUSelB, 
output reg [31:0] ALUInB
);

always@(*)
begin
    case(ForwardB)
        2'b00 : ALUInB <= ALUSelB;
        2'b01 : ALUInB <= WD;
        2'b10 : ALUInB <= EX_MEM_ALUResult;
        default : ALUInB <=32'b0;
    endcase
end
endmodule
