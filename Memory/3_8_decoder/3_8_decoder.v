/* ENGR 468 - Milestone #2 Memory
 3-8 decoder module
*/


module decoder(dest, enable);
	input[2:0] dest;
	output reg[7:0] enable;
	always @(dest) 
	begin
		case(dest)
			0: enable = 8'b00000001;
			1: enable = 8'b00000010;
			2: enable = 8'b00000100;
			3: enable = 8'b00001000;
			4: enable = 8'b00010000;
			5: enable = 8'b00100000;
			6: enable = 8'b01000000;
			7: enable = 8'b10000000;
			default assign enable = 8'b00000001;
		endcase
	end
endmodule
	
	