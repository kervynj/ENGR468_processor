`include "3_8_decoder.v"

/* ENGR 468 - Milestone #2 Memory
 3-8 decoder test bench module
*/

module decoder_tb();
	reg[2:0] destreg;
	wire[7:0] en;
	
	initial
	begin
		destreg = 3'b000;
		#10;
		destreg = 3'b001;
		#10;
		destreg = 3'b010;
		#10;
		destreg = 3'b011;
		#10;
		destreg = 3'b100;
		#10;
		destreg = 3'b101;
		#10;
		destreg = 3'b110;
		#10;
		destreg = 3'b111;
		#10;
		$finish();
	end
	
	decoder MUT(destreg, en);
	
	initial
	begin
	$monitor("time = %d destreg =%d enable = %b", $time, destreg, en);
	end
endmodule


	