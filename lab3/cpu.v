`include "opcodes.v" 	   
`include "register.v"
`include "alu.v"
`include "mux.v"

module cpu (readM, writeM, address, data, ackOutput, inputReady, reset_n, clk);
	output readM;									
	output writeM;								
	output [`WORD_SIZE-1:0] address;	
	inout [`WORD_SIZE-1:0] data;		
	input ackOutput;								
	input inputReady;								
	input reset_n;									
	input clk;

	reg [`WORD_SIZE-1:0] address;
	reg [`WORD_SIZE-1:0] PC;
	reg readM, writeM;
	reg [1:0] CS, NS;
	reg [`WORD_SIZE-1:0]data

	wire [`WORD_SIZE-1:0] regData1, regData2
	
	initial begin // Initial Logic
		assign data = 16'bz;
		assign PC = 0;
		assign CS = 0;
		assign NS = 0;
	end

	always @(*) begin // Calculation: Combinational Logic
		if (CS == 1) begin // TODO: ID & EX
			if(data[15:12]==15)begin
				
				if(data[5:0]<8)begin
					
				end
			end
			else if(data[15:12]>8)begin
			end
			else begin
			end
		end
		else begin // TODO: MEM (Memory Access Stage)
		end
	end

	always @(posedge inputReady) begin // ID & EX
		CS <= NS;
		readM <= 0;
		writeM <= 0;
	end
	always @(posedge ackOutput) begin // Write Back
		CS <= 0;
		NS <= 0;
		readM <= 0;
		writeM <= 0;
	end

	
	always @(posedge clk) begin // Clock I
		if (CS == 0) begin
			readM <= 1;
			writeM <= 0;
			NS <= 1;
		end
	end
	always @(negedge clk) begin // Clock II
		if (NS == 2) begin //Store
			readM <= 0;
			writeM <= 1;
		end
		else if(NS == 3)begin //Load
			readM <= 1;
			writeM <= 0;
		end
		
	end
	

	always @(negedge reset_n) begin // Reset Activated

	end																																				  
endmodule							  																		  