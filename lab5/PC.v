`include "macro.v"

module PC (clk, reset_n, hazard, PC_cur, PC_next);
	input reset_n, clk, hazard;
	
	output reg [`WORD_SIZE-1:0] PC_cur;
	input [`WORD_SIZE-1:0] PC_next;

	initial begin
		PC_cur = 0;
	end

	always @(posedge clk) begin
		if (!reset_n) begin
			// $display ("CPU-RESET cur: %d", PC_cur);
			PC_cur <= 0;
		end
		// Consider Hazard
		else if (hazard == 0) begin
			PC_cur <= PC_next;
		end
	end

endmodule
