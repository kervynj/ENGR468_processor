/* ENGR 468 - Milestone #2 Memory
 8-1 mulitplexer module
*/

module mux(Q, sel, source, state);
	
	input[127:0] Q;
	input[2:0] sel;
	input[1:0] state;
	wire[15:0] next_source;
	
	output reg[15:0] source;
	
	assign next_source = (sel == 0)? Q[15:0] : (sel == 1)? Q[31:16] : (sel == 2)? Q[47:32] : (sel ==3)? Q[63:48] : (sel==4)? Q[79:64] : (sel==5)? Q[95:80] : (sel==6)? Q[111:96] : Q[127:112];
	
	always@(state)
	begin
		if (state == 1)
			source = next_source;	//pass register value through only on 'decode' cycle
	end
	
endmodule 
