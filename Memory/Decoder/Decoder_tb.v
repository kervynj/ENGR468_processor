`include "Decoder.v"

module Decoder_tb();
	
	reg[15:0] inst; // 16 bit instruction input from ROM for decoding
	wire[1:0] cond; // 2 bits MSG for condition
	wire[3:0] opcd, source2; // op code and shift bits
	wire[2:0] dest, source;  // 3bits desitination register (R7 max)
	
	initial 
	begin
		inst = 16'b0000010010100000; // opcd = 0001, dest =1, source =2,
		#5
		inst = 16'b0000100010100000; // opcd = 0001, dest =1, source =2,
		#5
		inst = 16'b0000110100010000; // opcd = 0011, dest =2, source =1,

		$finish();
	end
	
	initial begin
		$monitor("t= %d, inst= %d,opcd= %d, dest= %d, source= %d, source2= %d", $time, cond, opcd, dest, source, source2);
	end
	
	Decoder MUT(inst, cond, opcd, dest, source, source2);
	
endmodule
	
	