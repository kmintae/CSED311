// Title         : vending_machine.v
// Author      : Jae-Eon Jo (Jojaeeon@postech.ac.kr) 
//					   Dongup Kwon (nankdu7@postech.ac.kr) (2015.03.30)

`include "vending_machine_def.v"

module vending_machine (

	clk,							// Clock signal
	reset_n,						// Reset signal (active-low)
	
	i_input_coin,				// coin is inserted.
	i_select_item,				// item is selected.
	i_trigger_return,			// change-return is triggered 
	
	o_available_item,			// Sign of the item availability
	o_output_item,			// Sign of the item withdrawal
	o_return_coin				// Sign of the coin return
);

	// Ports Declaration
	// Do not modify the module interface
	input clk;
	input reset_n;
	
	input [`kNumCoins-1:0] i_input_coin;
	input [`kNumItems-1:0] i_select_item;
	input i_trigger_return;
		
	output [`kNumItems-1:0] o_available_item;
	output [`kNumItems-1:0] o_output_item;
	output [`kNumCoins-1:0] o_return_coin;
 
	// Normally, every output is register,
	//   so that it can provide stable value to the outside.
	reg [`kNumItems-1:0] o_available_item;
	reg [`kNumItems-1:0] o_output_item;
	reg [`kNumCoins-1:0] o_return_coin;
	
	// Net constant values (prefix kk & CamelCase)
	// Please refer the wikepedia webpate to know the CamelCase practive of writing.
	// http://en.wikipedia.org/wiki/CamelCase
	// Do not modify the values.
	wire [31:0] kkItemPrice [`kNumItems-1:0];	// Price of each item
	wire [31:0] kkCoinValue [`kNumCoins-1:0];	// Value of each coin
	assign kkItemPrice[0] = 400;
	assign kkItemPrice[1] = 500;
	assign kkItemPrice[2] = 1000;
	assign kkItemPrice[3] = 2000;
	assign kkCoinValue[0] = 100;
	assign kkCoinValue[1] = 500;
	assign kkCoinValue[2] = 1000;


	// NOTE: integer will never be used other than special usages.
	// Only used for loop iteration.
	// You may add more integer variables for loop iteration.
	integer i, j, k;

	// Internal states. You may add your own net & reg variables.
	reg [`kTotalBits-1:0] current_total;
	
	// Next internal states. You may add your own net and reg variables.
	reg [`kTotalBits-1:0] current_total_nxt;
	
	// Variables. You may add more your own registers.
	reg [`kTotalBits-1:0] input_total, output_total, return_total;
	reg [31:0] waitTime;
	
	reg ret;
	
	reg CS, NS;

	// initiate values
	initial begin
		// TODO: initiate values
		waitTime = `kWaitTime;
		CS = 0;
		NS = 0;
		current_total = 0;
		current_total_nxt = 0;
		o_available_item = 0;
		o_output_item = 0;
		o_return_coin = 0;
		return_total = 0;

		ret=0;
	end

	
	// Combinational logic for the next states
	always @(i_input_coin,i_select_item,i_trigger_return) begin
		// TODO: current_total_nxt
		// You don't have to worry about concurrent activations in each input vector (or array).

		// Calculate the next current_total state.
		if(ret==0)begin
			if (CS == 0) begin // State 1
				waitTime = `kWaitTime;
				for (i = 0; i < `kNumCoins; i = i+1) begin
					if (i_input_coin[i] == 1) begin
						current_total_nxt = current_total + kkCoinValue[i];
						waitTime = `kWaitTime;
						NS = 1;
					end
				end
			end
			else begin // State 2
				if (i_trigger_return == 1) begin
					current_total_nxt=0;
					NS = 0;
				end
				for (i = 0; i < `kNumCoins; i = i+1) begin
					if (i_input_coin[i] == 1) begin
						current_total_nxt = current_total + kkCoinValue[i];
						waitTime = `kWaitTime;
					end
				end
				for (j = 0; j < `kNumItems; j = j+1) begin
					if (i_select_item[j] == 1) begin
						if (current_total>=kkItemPrice[j]) begin
							current_total_nxt = current_total - kkItemPrice[j];
							waitTime = `kWaitTime;
						end
					end
				end
			end
		end
	end

	// Combinational logic for the outputs
	always @(CS,NS,i_input_coin,i_select_item,i_trigger_return) begin
		// TODO: o_available_item
		
		if (CS == 1) begin
			for (i = 0; i < `kNumItems; i = i+1) begin
				if (kkItemPrice[i] <= current_total) begin
					o_available_item[i] = 1;
				end
				else begin
					o_available_item[i] = 0;
				end
			end
		end

		// TODO: o_output_item
		for (j = 0; j < `kNumItems; j = j+1) begin
			if (i_select_item[j] == 1 && current_total>=kkItemPrice[j]) begin
				o_output_item[j] = 1;
			end
			else begin
				o_output_item[j] = 0;
			end
		end

		// TODO: o_return_coin
		if (i_trigger_return == 1 ||waitTime<=0||ret==1) begin
			// TODO: Return
			for(i=0; i<`kNumCoins;i = i+1)begin
				o_return_coin[i]=0;
			end
			for(i=0; i<`kNumCoins;i = i+1)begin
				if(return_total>kkCoinValue[i]&&o_return_coin==3'b000)begin
					o_return_coin[i]=1;
				end
			end
			
			if(return_total<=0)begin
				ret=0;
				waitTime=`kWaitTime;
			end
		end
	end
	
	
	// Sequential circuit to reset or update the states
	always @(posedge clk,negedge reset_n) begin
		if (!reset_n) begin
			// TODO: reset all states.
			CS <= 0;
			current_total <= 0;
			current_total_nxt <= 0;
		end
		else begin
			// TODO: update all states.
			waitTime <= waitTime - 1;
			return_total<=current_total;
			if(waitTime<=0)begin
				current_total_nxt<=0;
				NS <= 0;
				ret<=1;
			end
			else begin
				CS <= NS;
				current_total <= current_total_nxt;
			end

		end
	end

endmodule
