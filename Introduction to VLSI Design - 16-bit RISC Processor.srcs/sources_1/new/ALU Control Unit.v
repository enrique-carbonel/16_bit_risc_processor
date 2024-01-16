// Code for ALU Control Unit of RISC Processor

`timescale 1ns / 1ps

module alu_control( ALUControlSignal, ALUOp, operationCode);
 output reg[2:0] ALUControlSignal; // 3-bit register. Control Signal for the ALU.
 input [1:0] ALUOp; // 2-bit input. Represents the Control Information of the ALU.
 input [3:0] operationCode; // 4-bit input. Operation code of the instruction.
 wire [5:0] ALUControlIn; // 6-bit wire. Control signals of the ALU. 
 assign ALUControlIn = {ALUOp,operationCode}; // Assignation of ALU control information and operation code.
 always @(ALUControlIn) // Every time that ALUControlIn changes, perform a casex statement.
 casex (ALUControlIn)
   6'b10xxxx: ALUControlSignal=3'b000; // x means don't care bits.
   6'b01xxxx: ALUControlSignal=3'b001;
   6'b000010: ALUControlSignal=3'b000;
   6'b000011: ALUControlSignal=3'b001;
   6'b000100: ALUControlSignal=3'b010;
   6'b000101: ALUControlSignal=3'b011;
   6'b000110: ALUControlSignal=3'b100;
   6'b000111: ALUControlSignal=3'b101;
   6'b001000: ALUControlSignal=3'b110;
   6'b001001: ALUControlSignal=3'b111;
  default: ALUControlSignal=3'b000; // Degault value is 3-bit 0.
  endcase
endmodule