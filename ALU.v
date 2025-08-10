`timescale 1ns / 1ps
module ALU (
input [31:0] ALUInA, ALUInB,
input [1:0] ALUControlSignal,
output reg [31:0] ALUResult
);

wire [31:0] Sum, Diff;

always @(*) begin
    case (ALUControlSignal)
        2'b00: ALUResult = (ALUInA & ALUInB);  //AND operation
        2'b01: ALUResult = (ALUInA | ALUInB);  //OR operation
        2'b10: ALUResult = ALUInA + ALUInB;  //ADD operation
        2'b11: ALUResult = ~(ALUInA & ALUInB);  //NAND operation
        default: ALUResult = 32'b0;
    endcase
end

endmodule