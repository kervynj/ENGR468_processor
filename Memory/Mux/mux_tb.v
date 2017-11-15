`include "mux.v"

/* ENGR 468 - Milestone #2 Memory
 Mux test bench module
*/

module mux_tb();

	reg[127:0] Q;
	reg[2:0] sel;
	wire[15:0] source;

	
	initial 
	begin
		Q = 0;
		#10;
		sel = 0;
		Q = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'hFFFF};
		#10;
		sel = 1;
		Q = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'hFFFF, 16'h0000};
		#10;
		sel = 2;
		Q = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'hFFFF, 16'h0000, 16'h0000};
		#10;
		sel = 3;
		Q = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'hFFFF, 16'h0000, 16'h0000, 16'h0000};
		#10;
		sel = 4;
		Q = {16'h0000, 16'h0000, 16'h0000, 16'hFFFF, 16'h0000, 16'h0000, 16'h0000, 16'h0000};
		#10;
		sel = 5;
		Q = {16'h0000, 16'h0000, 16'hFFFF, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000};
		#10;
		sel = 6;
		Q = {16'h0000, 16'hFFFF, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000};
		#10;
		sel = 7;
		Q = {16'hFFFF, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000};
		#10;
		
		$finish();
	end
	
	mux MUT(Q, sel, source);
	
	initial
	begin	
		$monitor("time = %d sel = %d Q = %h, output =%h", $time, sel, Q, source);
	end
endmodule
	
	
	
		
			
		