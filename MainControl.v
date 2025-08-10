`timescale 1ns / 1ps

module MainControl(input Clk,
input [3:0] OpCode,
output PCSrc, EnIM,
output reg ALUSrcB, MReg, EnRW, MR, MW, 
output reg [1:0] ALUOp
);

assign PCSrc=0; //no branching operation
assign EnIM=1;
always@(negedge Clk)
begin
    if(OpCode == 4'b0000) //AND
    begin 
        ALUSrcB<=1;
        MReg<=0;
        EnRW<=1;
        MR<=0;
        MW<=0;
        ALUOp <=2'b00;
    end 
    
    else if(OpCode == 4'b0001) //ORI
    begin 
        ALUSrcB<=0;
        MReg<=0;
        EnRW<=1;
        MR<=0;
        MW<=0;
        ALUOp <=2'b01;
    end 
    else if(OpCode == 4'b0011) //SW
    begin 
        ALUSrcB<=0;
        MReg<=1;
        EnRW<=0;
        MR<=0;
        MW<=1;
        ALUOp <=2'b10;
    end 
    
    else if(OpCode == 4'b0111) //NAND
    begin 
        ALUSrcB<=1;
        MReg<=0;
        EnRW<=1;
        MR<=0;
        MW<=0;
        ALUOp <=2'b11;
    end 
    
    else if(OpCode == 4'b1111) //ADD
    begin 
        ALUSrcB<=1;
        MReg<=0;
        EnRW<=1;
        MR<=0;
        MW<=0;
        ALUOp <=2'b10;
    end 
end

endmodule
