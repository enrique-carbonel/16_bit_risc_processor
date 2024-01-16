// Verilog testbench code to test the processor

`timescale 1ns / 1ps
`include "C:/Users/enriq/Downloads/Introduction to VLSI Design - 16-bit RISC Processor/Introduction to VLSI Design - 16-bit RISC Processor.srcs/sources_1/new/parameter.v"

module test_Risc_16_bit;

 // Inputs
reg clk;

 // Instantiate the Unit Under Test (UUT)
 Risc_16_bit uut (
  .clk(clk)
 );
 
 initial 
  begin
   clk <=0;
   `simulation_time;
   $finish;
  end

 always 
  begin
   #5 clk = ~clk;
  end

endmodule