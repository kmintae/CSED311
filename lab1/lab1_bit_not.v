// lab1_bit_not.v

// Bitwise NOT
// Calculation

// Output 1: C; calculation result, 16bit binary
// Output 2: OverflowFlag; 0
// Input 1: A; input, 16bit binary
// Input 2: E; enable, 1bit binary

module bit_not16 (output [15:0] C, output OverflowFlag,
	input [15:0] A, input E);
	reg result;
	assign OverflowFlag = 1'b0;
	assign C=(E & 1'b1)?~A:16'b0000000000000000;
endmodule
