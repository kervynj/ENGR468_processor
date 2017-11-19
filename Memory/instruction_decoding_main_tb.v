`include "instruction_decoding_main.v"

module instr_mem_decoder_main_tb();

	reg oeb, clock; 				  
	reg[15:0] ALU_data;		       
		
	wire[15:0] source1, source2;   
	
	wire[3:0] opcode;
	
	integer i;
	
	instr_mem_decoder_main MUT(source1, source2, opcode, clock);
	
	
	initial
	begin
	
		$dumpfile("module2_test.vcd");
		$dumpvars(0,instr_mem_decoder_main_tb);
		
		MUT.current_state = 0;
		MUT.pc = 0;
		MUT.rw_RAM = 1;
		MUT.chip_enable = 1;
		MUT.rw = 1;
		
		
		$readmemb("ROM_instructions.txt", MUT.rom.mem); // intialize ROM memory

		
		for(i=0; i<16; i = i+1)
		begin	
			$display("data[%d] = %h", i, MUT.rom.mem[i]);
		end
		
		$writememh("ROM_filled.txt", MUT.rom.mem);
		$readmemh("initial_ram_data.txt", MUT.ram.mem); // initialize RAM memory 

		
		oeb = 1;
		clock = 0;
		ALU_data = 16'h0001;
		
		#300;
		
		ALU_data = 16'hFFFF;
		
		$finish();	
	end
	
	initial 
	begin
		$monitor("clock =%d, current_state =%d, pc = %d, inst=%h, rw_RAM =%b, dataIn =%h, source1=%h, source2=%h, select1= %d, select2 = %d", clock, MUT.current_state, MUT.pc, MUT.inst, MUT.rw_RAM, ALU_data, source1, source2, MUT.select1, MUT.select2);
	end
	
	
	always
	begin	
		clock = !clock;
		#5;
	end
endmodule
	
	
	
	
		
		
			
			
		
		
		
		