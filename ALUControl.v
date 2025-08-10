`timescale 1ns / 1ps

module ALUControl(
input [1:0] ID_EX_ALUOp, 
output reg [1:0] ALUControlSignal
);

always @(*) begin
    case (ID_EX_ALUOp)
        2'b00: ALUControlSignal = 2'b00; // AND
        2'b01: ALUControlSignal = 2'b01; // ORI
        2'b10: ALUControlSignal = 2'b10; // ADD
        2'b11: ALUControlSignal = 2'b11; // NAND
            
        default: ALUControlSignal = 2'b10;
    endcase
end
endmodule
