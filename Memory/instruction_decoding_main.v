`include "\ROM\ROM.v"
`include "\splitter\splitter.v"
`include "\Register Bank\RAM.v"



module instr_mem_decoder_main(source1, source2, opcode, clock);

	input clock;
	input [15:0] ALU_data;		       // output from ALU to be written back to reg bank
	
	reg rw;
	reg[1:0] current_state, next_state;
	reg[2:0] pc; 					// program counter  
	reg rw_RAM, chip_enable;
	
	output[15:0] source1, source2;// decoded register data to ALU
	
	wire[15:0] inst;            // fetched instruction set from ROM
	wire[2:0] en; 	           // enable signals to register set			  
	output[3:0] opcode; 
	wire[2:0] dest, select1;
	wire[3:0]select2;
	
	
	// FSM state (fetch, decode, execute) architecture
	always@(current_state)
	begin
		
		chip_enable = 1;
	
		if (current_state == 2)	//during execution, write back ALU data to RAM and increment PC
		begin
			rw = 0;
			next_state = 0;
			pc = pc +1;
			rw_RAM = 0;
		end
		
		else if(current_state ==1)	// during execution, turn ROM to high-impedance, read desired registers and output to ALU
		begin
			rw = 0;	
			rw_RAM = 1; 
			next_state = current_state + 1;
		end
		else	
		begin
			rw= 1;
			rw_RAM = 0;
			next_state = current_state +1;
		end	
	end
	
	
	always@(posedge clock)
	begin
		current_state = next_state;
	end
	
	
	// connect sub-modules to generate hardware architecture
	ROM rom(.oeb(rw),
			.inst(inst),
			.pc(pc)
			);
			
			
	splitter split(.inst(inst),
        	       .cond(),
  				   .opcd(opcode),
				   .dest(dest),
				   .source(select1),
				   .source2(select2)
				   );
	
	RAM ram(.rw(rw_RAM),
			.chip_enable(chip_enable),
			.enable(en),
			.select1(select1),
			.select2(select2[3:1]),
			.dataIn(ALU_data),
			.source1(source1),
			.source2(source2));
		 
endmodule
					   
	

	
	
	
	