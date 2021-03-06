// lab1_signsub.v

// Signed Subtraction
// Calculation + Examining Overflow

// Output 1: C; calculation result, 16bit binary
// Output 2: OverflowFlag; boolean checking existing overflow, 1bit binary
// Input 1: A; input, 16bit binary
// Input 2: B; input, 16bit binary
// Input 3: E; enable, 1bit binary

`include "lab1_2comp.v"

module sign_subtractor16 (output wire [15:0] C, output wire OverflowFlag,
	input [15:0] A, input [15:0] B, input E);

	wire rem_1;
	wire [15:0] B_comp;
	wire [15:0] result;
	wire OverflowFlag_temp;
	assign C=(E==1'b1)?result:16'b0000000000000000;

	complement_16 op_1 (B_comp, rem_1, B, E);
	sign_adder16 op_2 (result, OverflowFlag_temp, A, B_comp, E);
	assign OverflowFlag=(E==1'b1)?OverflowFlag_temp:1'b0;

endmodule
