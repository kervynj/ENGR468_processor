/* ENGR 468 - Milestone #2 Memory
Register module
*/

module register_bank(enable, destination_data, q);
	input [7:0] enable;	// enable for 8 registers
	input [15:0] destination_data; // data returned from ALU block
	output [127:0] q; // 16 bit output from 8 register
	genvar i;
		
	generate for (i =0; i<8; i= i+1)
	begin
		register r(q[16*i +: 16], destination_data, enable[i]);
	end
	endgenerate 
endmodule	


module register(Q, D, en);
	input en;
	input[15:0] D;
	output reg[15:0] Q;
	
	always @(*)
	begin
		if (en == 1'b1)
			Q = D;
	end
	
	
endmodule
	
	