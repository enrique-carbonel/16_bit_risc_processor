# 16_bit_risc_processor
Verliog code implementing a 16-bit RISC processor to execute instructions in a streamlined manner, employing a simplified instruction set to enhance performance. This project was made for my Introduction to VLSI Design class.

IDE USED: AMD Vivado 2023.1
Language used: Verilog

The processor architecture consists of two fundamental units: the Datapath Unit and the Control Unit. The Datapath Unit is responsible for executing arithmetic, logic, and data transfer operations specified by the instruction set. It includes components such as registers, ALU (Arithmetic Logic Unit), multiplexers, and memory units. The ALU performs arithmetic and logical operations on operands fetched from registers or memory. The Control Unit orchestrates the flow of instructions within the processor. It generates control signals required to coordinate the Datapath Unit components based on the instruction being 
executed. It interprets the opcode of instructions and generates appropriate control signals to direct the Datapath Unit. The top-level module integrates the Datapath Unit and Control Unit. It has a clock input to synchronize and drive the processor's operations. Interfaces with external components or memory modules for instruction fetching and data storage.

In order to make the 16-bit RISC Processor run its simulation, it is necessary to change the filepath location from four different modules. 

The first module is the Instruction Memory, The Data Memory, the parameter, and the Testbench.

You just need to change the location up until /test.data, /test.prog, /50001111_50001212.o, and /Parameter.v

These files can be found under /.srcs/sources_1/new

You can change the values of test.data and test.prog as you wish to provide the initial data memory values and the instructions. Please open the report to see the tables of how it should be formatted. The tables should be on the Appendix.

