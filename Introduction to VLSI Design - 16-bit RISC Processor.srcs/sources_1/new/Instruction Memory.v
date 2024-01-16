// Code for Instruction Memory.

`include "Parameter.v"

module Instruction_Memory(
 input[15:0] programCounter, // Program counter. Will specify the address of the instruction that memory will fetch.
 output[15:0] instruction // Variable that will show the instruction assigned.
);

 reg [`col - 1:0] memory [`row_i - 1:0]; // 2-D array using registers. This array will store instructions. Using parameters from the Parameter.v file.
 wire [3 : 0] rom_addr = programCounter[4 : 1]; // Extraction of 4-bits from the program counter. This is used as an address to access the instruction memory.
 initial
 begin
  $readmemb("C:/Users/enriq/Downloads/Introduction to VLSI Design - 16-bit RISC Processor/Introduction to VLSI Design - 16-bit RISC Processor.srcs/sources_1/new/test.prog", memory,0,14); // Reads file and initializes the memory array with values from the file itself.
 end
 assign instruction =  memory[rom_addr]; // Uses the address (rom_addr) to index into the memory and assigns the instructions to "instruction".

endmodule
