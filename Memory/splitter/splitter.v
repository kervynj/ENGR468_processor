/* ENGR 468 - Milestone #2 Memory
Decoder splitting module
*/

module splitter(inst, cond, opcd, dest, source, source2);

	input[15:0] inst; // 16 bit instruction input from ROM for decoding
	output [1:0] cond; // 2 bits MSG for condition
	output [3:0] opcd, source2; // op code and shift bits
	output [2:0] dest, source;  // 3bits desitination register (R7 max)
	
	assign cond = inst[15:14];
    assign opcd = inst[13:10];
	assign dest = inst[9:7];
	assign source = inst[6:4];
    assign source2 = inst[3:0];
	
endmodule 

