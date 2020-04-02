// lab1_signadd.v

// Signed Addition
// Calculation + Examining Overflow

// Output 1: C; calculation result, 16bit binary
// Output 2: OverflowFlag; boolean checking existing overflow, 1bit binary
// Input 1: A; input, 16bit binary
// Input 2: B; input, 16bit binary
// Input 3: E; enable, 1bit binary

`include "lab1_adder.v"

module sign_adder16 (output [15:0] C, output OverflowFlag,
	input [15:0] A, input [15:0] B, input E);
	
	wire Carry_in_LSB = 0;
	wire [15:0] Carry;
	wire [15:0] sum;
	wire OverflowFlag_temp;
	assign C=(E==1'b1)?sum:16'b0000000000000000;

	adder1 op_1 (sum[0], Carry[0], A[0], B[0], Carry_in_LSB);
	adder1 op_2 (sum[1], Carry[1], A[1], B[1], Carry[0]);
	adder1 op_3 (sum[2], Carry[2], A[2], B[2], Carry[1]);
	adder1 op_4 (sum[3], Carry[3], A[3], B[3], Carry[2]);
	adder1 op_5 (sum[4], Carry[4], A[4], B[4], Carry[3]);
	adder1 op_6 (sum[5], Carry[5], A[5], B[5], Carry[4]);
	adder1 op_7 (sum[6], Carry[6], A[6], B[6], Carry[5]);
	adder1 op_8 (sum[7], Carry[7], A[7], B[7], Carry[6]);
	adder1 op_9 (sum[8], Carry[8], A[8], B[8], Carry[7]);
	adder1 op_10 (sum[9], Carry[9], A[9], B[9], Carry[8]);
	adder1 op_11 (sum[10], Carry[10], A[10], B[10], Carry[9]);
	adder1 op_12 (sum[11], Carry[11], A[11], B[11], Carry[10]);
	adder1 op_13 (sum[12], Carry[12], A[12], B[12], Carry[11]);
	adder1 op_14 (sum[13], Carry[13], A[13], B[13], Carry[12]);
	adder1 op_15 (sum[14], Carry[14], A[14], B[14], Carry[13]);
	adder1 op_16 (sum[15], Carry[15], A[15], B[15], Carry[14]);
	xor op_17 (OverflowFlag_temp, Carry[15], Carry[14]);
	assign OverflowFlag=(E==1'b1)?OverflowFlag_temp:1'b0;
	
endmodule
