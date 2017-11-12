/* ENGR 468 - Milestone #2 Memory
Decoder module
*/


module Decoder(inst, cond, opcd, dest, source, source2);

	input[15:0] inst; // 16 bit instruction input from ROM for decoding
	output reg [1:0] cond; // 2 bits MSG for condition
	output reg [3:0] opcd, source2; // op code and shift bits
	output reg [2:0] dest, source;  // 3bits desitination register (R7 max)
	
	always @(inst)
	begin
		cond = inst[15:14];
		opcd = inst[13:10];
		dest = inst[9:7];
		source = inst[6:4];
		source2 = inst[3:0];
	end
endmodule 

