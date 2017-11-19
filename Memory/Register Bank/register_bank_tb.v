`include "register_bank.v"

/* ENGR 468 - Milestone #2 Memory
Register test bench module
*/

module register_bank_tb();
	reg[7:0] en; // 8 bit enable inputs to register bank
	reg[15:0] alu_data; // output data from ALU to register bank
	output [127:0] Q; // 16 bit output from 8 registers in bank
	integer i;
	
	initial
	begin
		alu_data = 16'h000F; // test value for destination register data
		for (i=0; i<127; i=i+1)
		begin
			en = i;
			#5;
			en = 0;
			#5;
		end
	end
	
	register_bank MUT(en, alu_data, Q);
	
	initial
	begin
		$monitor("t=%d  en= %d  alu_data= %d  Q= %d\n", $time, en, alu_data, Q);
	end
endmodule 
	