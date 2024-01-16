// Code for the Datapath of RISC Processor.

`timescale 1ns / 1ps

module Datapath_Unit(
 input clk, // Clock.
 input jump, beq , mem_read, mem_write, alu_src,reg_dst, mem_to_reg, reg_write, bne, // Inputs.
 input[1:0] alu_op, // 2-bit ALU Operator.
 output[3:0] opcode // 4-bit operation code.
);
 reg  [15:0] pc_current; // Current program counter.
 wire [15:0] pc_next,pc2; // Next program counter. Next, is program counter incremented by 2.
 wire [15:0] instr; // Instruction.
 wire [2:0] reg_write_dest; // Register write destination.
 wire [15:0] reg_write_data; // Register write data.
 wire [2:0] reg_read_addr_1; // Register read address 1.
 wire [15:0] reg_read_data_1; // Register read data 1.
 wire [2:0] reg_read_addr_2; // Register read address 2.
 wire [15:0] reg_read_data_2; // Register read data 2.
 wire [15:0] ext_im,read_data2; // Sign extendsed immediate value. 
 wire [2:0] ALU_Control; // ALU control.
 wire [15:0] ALU_out; // ALU output.
 wire zero_flag; // zero flag.
 wire [15:0] PC_j, PC_beq, PC_2beq,PC_2bne,PC_bne; // Program counter wires for different functions (jump, branch on equal, branch on equal skip 2, branch not equal, branch not equal skip 2)
 wire beq_control; // Branch on equal control.
 wire [12:0] jump_shift; // Jump shift.
 wire [15:0] mem_read_data; // Memory read data. 

 initial begin
  pc_current <= 16'd0; // Initial value of current program counter is 0.
 end
 always @(posedge clk) // Every time that the clock is positive edge, perform the code. 
 begin 
   pc_current <= pc_next; // PC next will not turn into current every time that the positive edge clock moves.
 end
 assign pc2 = pc_current + 16'd2; // Here we are making pc2 so that way it actually is the program counter + 2.
 
 // instruction memory
 Instruction_Memory im(.programCounter(pc_current),.instruction(instr)); // Calling the instruction memory to perform action.
 
 assign jump_shift = {instr[11:0],1'b0}; // jump shift left 2
 
 assign reg_write_dest = (reg_dst==1'b1) ? instr[5:3] :instr[8:6]; // multiplexer regdest. if reg_dst = 1, then assign instr[5:3], else assign instr[8:6].
 
 // register file
 assign reg_read_addr_1 = instr[11:9];
 assign reg_read_addr_2 = instr[8:6];

 // GENERAL PURPOSE REGISTERs
 GPRs reg_file
 (
  .clk(clk),
  .registerWriteEnable(reg_write),
  .registerWriteDestination(reg_write_dest),
  .registerWriteData(reg_write_data),
  .registerReadAddress_1(reg_read_addr_1),
  .registerReadData_1(reg_read_data_1),
  .registerReadAddress_2(reg_read_addr_2),
  .registerReadData_2(reg_read_data_2)
 );
 
 // immediate extend
 assign ext_im = {{10{instr[5]}},instr[5:0]}; // Extending a 6-bit immediate value to a 16-bit value, replicating the sign bit to the left.
 
 // ALU control unit
 alu_control ALU_Control_unit(.ALUControlSignal(ALU_Control), .ALUOp(alu_op), .operationCode(instr[15:12]));
 
 // multiplexer alu_src
 assign read_data2 = (alu_src==1'b1) ? ext_im : reg_read_data_2; // If alu_src = 1, then read data will be ext_im, else it will be the register read data 2.
 
 // ALU 
 ALU alu_unit(.a(reg_read_data_1),.b(read_data2),.select(ALU_Control),.result(ALU_out),.zero(zero_flag));
 
 // PC beq add
 assign PC_beq = pc2 + {ext_im[14:0],1'b0}; // Adding the branch on equal.
 assign PC_bne = pc2 + {ext_im[14:0],1'b0}; // Adding the branch not on equal.
 
 // beq control
 assign beq_control = beq & zero_flag; // Branch on equal control.
 assign bne_control = bne & (~zero_flag); // Branch not on equal control.
 // PC_beq
 assign PC_2beq = (beq_control==1'b1) ? PC_beq : pc2; // Adding 2 units on the program counter when branch is equal.
 // PC_bne
 assign PC_2bne = (bne_control==1'b1) ? PC_bne : PC_2beq; // Adding 2 units on the program counter when branch is not on equal.
 // PC_j
 assign PC_j = {pc2[15:13],jump_shift}; // Jumping on the program counter.
 // PC_next
 assign pc_next = (jump == 1'b1) ? PC_j :  PC_2bne; // Changing the program counter to the next value.

 /// Data memory
  Data_Memory dm
   (
    .clk(clk),
    .memoryAccessAddress(ALU_out),
    .memoryWriteData(reg_read_data_2),
    .memoryWriteEnable(mem_write),
    .memoryReadEnable(mem_read),
    .memoryReadData(mem_read_data)
   );
 
 assign reg_write_data = (mem_to_reg == 1'b1)?  mem_read_data: ALU_out; // If memory to register is enabled, then the write data is equal to the read data, else it is the ALU output.

 assign opcode = instr[15:12]; // Operation code is equal to the last 3-bits of instruction.
 
endmodule