`timescale 1ns / 1ps


module InstructionMemory(
input EnIM,
input [31:0]ADDR, 
output reg [31:0] RD
);

reg [7:0]InstMem [0:31];

always@(*)
begin
    if(EnIM)
        RD ={InstMem[ADDR],InstMem[ADDR+1],InstMem[ADDR+2],InstMem[ADDR+3]};
end

endmodule
                    
                    
