// Code for general purpose register file.

`timescale 1ns / 1ps

module GPRs(
 input clk, // Clock.
 // write port.
 input    registerWriteEnable, // Will determine if register will write or not.
 input  [2:0] registerWriteDestination, // Destination address of write operation.
 input  [15:0] registerWriteData, // Data to be written to the register.
 //read port 1.
 input  [2:0] registerReadAddress_1, // Address for read port 1.
 output  [15:0] registerReadData_1, // Data output of read port 1.
 //read port 2.
 input  [2:0] registerReadAddress_2, // Address for read port 2.
 output  [15:0] registerReadData_2 // Data output of read port 2.
);
 reg [15:0] registerArray [7:0]; // Register array of 8 registers, each of 16-bits.
 integer x; // Integer x for for loop.
 // write port.
 //reg [2:0] i;
 initial begin
  for(x=0;x<8;x=x+1)
   registerArray[x] <= 16'd0; // Initialization of all registers to zero.
 end
 always @ (posedge clk ) begin
   if(registerWriteEnable) begin // If write enable of register is enabled, run the following code.
    registerArray[registerWriteDestination] <= registerWriteData; // Write the data to the write destination on the register array.
   end
 end
 

 assign registerReadData_1 = registerArray[registerReadAddress_1]; // Output the data from the register file at the address specified registerReadAddress_1.
 assign registerReadData_2 = registerArray[registerReadAddress_2]; // Output the data from the register file at the address specified registerReadAddress_2.


endmodule