`include "\Memory\ROM\ROM.v"
`include "\Memory\splitter\splitter.v"
`include "\Memory\Register Bank\RAM.v"
`include "\ALU\ALU_main.v"


module CPU(clock);

	input clock;
	wire [15:0] ALU_data;		       // output from ALU to be written back to reg bank
	
	reg rw, rw_RAM, chip_enable, execute;
	reg[1:0] current_state, next_state;
	reg[2:0] pc; 					// program counter  
	
	wire[15:0] source1, source2;// decoded register data to ALU
	
	wire[15:0] inst;            // fetched instruction set from ROM
	wire[1:0] cond;
	wire[3:0] opcode; 
	wire[2:0] dest, select1;
	wire[3:0]select2;
	wire[3:0]flags;	
	
	// FSM state (fetch, decode, execute) architecture
	always@(current_state)
	begin
	
		if (current_state == 2)	//during execution, write back ALU response to RAM and increment PC
		begin
		
			execute =  ((cond == 2'b00) & flags[0]==1'b1)? 1'b0:(cond == 2'b01 & flags[0]==0)? 1'b0: (cond == 2'b10 & flags[2]==0)? 1'b0: 1'b1; //conditional execution
			next_state = 0;
			rw = 0;
			pc = pc +1;
			chip_enable = (execute)? 1: 0;	// disable ROM if execute is false (no read, no write)
			rw_RAM = (opcode != 4'b1001)? 0: 1;	// ensure ROM is not written to during CMP instruction set
		end
		
		else if(current_state ==1)	// during decoding, turn ROM to high-impedance, read desired registers and output to ALU
		begin
			next_state = current_state + 1;
			chip_enable = 1;
			rw = 0;	
			rw_RAM = 1; // read registers for execution 
			execute = 0;
		end
		else	
		begin
			next_state = current_state +1;
			chip_enable = 0;
			execute = 0;
			rw = 1;
			rw_RAM = 0;
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
        	       .cond(cond),
  				   .opcd(opcode),
				   .dest(dest),
				   .source(select1),
				   .source2(select2)
				   );
	
	
	RAM ram(.rw(rw_RAM),
			.chip_enable(chip_enable),
			.enable(dest),
			.select1(select1),
			.select2(select2[3:1]),
			.dataIn(ALU_data),
			.source1(source1),
			.source2(source2),
			.opcode(opcode),
			.dest(dest));
			
			
	main alu(.r1(ALU_data),
			 .r2(source1),
			 .r3(source2),
			 .opcode(opcode),
			 .shift_bits(select2),
			 .flags(flags),
			 .execute(execute));
		 
endmodule
					   
	

	
	
	
	