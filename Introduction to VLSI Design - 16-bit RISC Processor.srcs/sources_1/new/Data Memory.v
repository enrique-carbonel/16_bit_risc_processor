// Code for data memory.

`include "Parameter.v"

module Data_Memory(
 input clk, // Clock.
 // address input, shared by read and write port
 input [15:0] memoryAccessAddress, // Address for memory access (read or write).
 // write port
 input [15:0] memoryWriteData, // Data to be written to the memory.
 input memoryWriteEnable, // Will determine if memory will write or not.
 input memoryReadEnable, // Will determine if memory will read or not.
 // read port
 output [15:0] memoryReadData // Data output of memory read.
);

reg [`col - 1:0] memory [`row_d - 1:0]; // 2-D array using registers. This array will store instructions. Using parameters from the Parameter.v file.
integer f; // Integer f used to store a file descriptor.
wire [2:0] ram_addr = memoryAccessAddress[2:0]; // Wire that extracts the lower 3-bits of the memoryAccessAddress. Used to index to the memory Array.
initial
 begin
  $readmemb("C:/Users/enriq/Downloads/Introduction to VLSI Design - 16-bit RISC Processor/Introduction to VLSI Design - 16-bit RISC Processor.srcs/sources_1/new/test.data", memory); // Reads contents of .data file and initializes the memory array with the values from the file.
  
  f = $fopen(`filename);
  $fmonitor(f, "time = %d\n", $time, // Prints the time and values of the first eight elements in the memory array to file.
  "\tmemory[0] = %b\n", memory[0],   
  "\tmemory[1] = %b\n", memory[1],
  "\tmemory[2] = %b\n", memory[2],
  "\tmemory[3] = %b\n", memory[3],
  "\tmemory[4] = %b\n", memory[4],
  "\tmemory[5] = %b\n", memory[5],
  "\tmemory[6] = %b\n", memory[6],
  "\tmemory[7] = %b\n", memory[7]);
  `simulation_time; // #160
  $fclose(f);
 end
 
 always @(posedge clk) begin
  if (memoryWriteEnable) // If write enable of memory is enabled, run the following code.
   memory[ram_addr] <= memoryWriteData; // Write the data to the memory array at the specified address.
 end
 assign memoryReadData = (memoryReadEnable==1'b1) ? memory[ram_addr]: 16'd0; // If the memoryReadEnable signal is on, outpuit the data from memory at the specified address, otherwise, output zero.

endmodule