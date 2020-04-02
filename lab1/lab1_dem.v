// lab1_dem.v

//test bench for lab1(Arithmetic Logic Unit)

`timescale 1ns/100ps

`include "lab1_alu.v"

module lab1_test;
	reg [15:0] a;
	reg [15:0] b;
	reg [3:0] func;
	wire [0:15] out;
	wire overFlowFlag;
	
	ALU alu(out,overFlowFlag,a,b,func);

	initial begin
		#100
		$display("time\t  A  B  FuncCode  C  OverflowFlag");
		$monitor("%T\t  %b	%b	%b	%b	%b",$time,a,b,func,out,overFlowFlag);
		
		//initialize inputs
		//case 1
		a=16'b0011_0101_0001_1111;
		b=16'b0011_0101_0001_1111;
		func=4'b0000;#10
		func=4'b0001;#10
		func=4'b0010;#10
		func=4'b0011;#10
		func=4'b0100;#10
		func=4'b0101;#10
		func=4'b0110;#10
		func=4'b0111;#10
		func=4'b1000;#10
		func=4'b1001;#10
		func=4'b1010;#10
		func=4'b1011;#10
		func=4'b1100;#10
		func=4'b1101;#10
		func=4'b1110;#10
		func=4'b1111;#10

		#100

		//case 2
		a=16'b1111_1111_1111_1111; b=16'b0000_0000_0000_0000;
		func=4'b0000;#10
		func=4'b0001;#10
		func=4'b0010;#10
		func=4'b0011;#10
		func=4'b0100;#10
		func=4'b0101;#10
		func=4'b0110;#10
		func=4'b0111;#10
		func=4'b1000;#10
		func=4'b1001;#10
		func=4'b1010;#10
		func=4'b1011;#10
		func=4'b1100;#10
		func=4'b1101;#10
		func=4'b1110;#10
		func=4'b1111;#10

		#100
		//case 3
		a=16'b0000_0111_1001_1011; b=16'b0010_0001_1001_1001;
		func=4'b0000;#10
		func=4'b0001;#10
		func=4'b0010;#10
		func=4'b0011;#10
		func=4'b0100;#10
		func=4'b0101;#10
		func=4'b0110;#10
		func=4'b0111;#10
		func=4'b1000;#10
		func=4'b1001;#10
		func=4'b1010;#10
		func=4'b1011;#10
		func=4'b1100;#10
		func=4'b1101;#10
		func=4'b1110;#10
		func=4'b1111;#10

		#100

		//case 4
		a=16'b0001_0011_0111_1111; b=16'b0110_0100_1011_0100;
		func=4'b0000;#10
		func=4'b0001;#10
		func=4'b0010;#10
		func=4'b0011;#10
		func=4'b0100;#10
		func=4'b0101;#10
		func=4'b0110;#10
		func=4'b0111;#10
		func=4'b1000;#10
		func=4'b1001;#10
		func=4'b1010;#10
		func=4'b1011;#10
		func=4'b1100;#10
		func=4'b1101;#10
		func=4'b1110;#10
		func=4'b1111;#10

		#100
		$stop;
	end
	
endmodule
	