// Code for Arithmetic Logic Unit (ALU)

module ALU(
 input  [15:0] a, // 16-bit a variable.
 input  [15:0] b, // 16-bit b variable.
 input  [2:0] select, // 3-bit select.
 
 output reg [15:0] result,  // 16-bit result variable.
 output zero // Indication if result is zero.
    );

always @(*) // Everytime that any of the input signals changes, perform the code below.
begin 
 case(select) // Case statement depending on the value of select.
 3'b000: result = a + b; // Addition.
 3'b001: result = a - b; // Subtraction.
 3'b010: result = ~a; // Bitwise NOT.
 3'b011: result = a << b; // Left Shift.
 3'b100: result = a >> b; // Right Shft.
 3'b101: result = a & b; // AND
 3'b110: result = a | b; // OR
 3'b111: begin if (a < b) result = 16'd1; // If a < b, then result will be all 16 1's.
    else result = 16'd0; // Else, the result will be all 16 0's.
    end
 default: result = a + b; // Default case is Addition.
 endcase
end
assign zero = (result==16'd0) ? 1'b1: 1'b0; // If result is all 16 0's, then it's true, else it's false.
 
endmodule