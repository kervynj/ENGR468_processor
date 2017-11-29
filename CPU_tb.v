`include "CPU.v"

module cpu_tb();
	
	reg clock;
	integer i, j;
	
	
	CPU cpu(clock);
	
	initial
	begin
		$dumpfile("CPU_test.vcd");
	
		$dumpvars(0,cpu_tb);
		
		clock = 0;
		
		cpu.current_state = 0;
		
		cpu.pc = 0;
		cpu.rw_RAM = 0;
		cpu.chip_enable = 1;
		cpu.rw = 1;
		cpu.alu.mx.return1=0;
		cpu.execute = 0;
		
		
		//$readmemh("lib/milestone3_instructions_bonus.txt", cpu.rom.mem); // intialize ROM memory
		$readmemb("lib/ROM_INITIAL.txt", cpu.rom.mem); // intialize ROM memory

		
		for(i=0; i<8; i = i+1)
		begin	
			$display("rom-data[%d] = %h", i, cpu.rom.mem[i]);
		end
		
		
		
		//$readmemh("lib/milestone3_ram_bonusinitial.txt", cpu.ram.mem); // initialize RAM memory 
		$readmemh("lib/register_initial.txt", cpu.ram.mem); // initialize RAM memory 

		
		$display("\n");
		
		
		for(j=0; j<16; j = j+1)
		begin	
			$display("ram-data[%d] = %h", j, cpu.ram.mem[j]);
		end
		
		
		
		$display("\n");

	
		#300
	
		$finish();
	end
	
	
	
	
	
	always
	begin
		clock = ~clock;
		#5;
	end
	
	initial
	begin	
		$monitor("state =%d, opcode =%b, source1 =%h, source2 =%h, ALU_output = %h, VZCN = %b, R0 = %h, R1=%h, R2=%h, R3=%h", cpu.current_state, cpu.opcode, cpu.source1, cpu.source2, cpu.ALU_data, cpu.flags, cpu.ram.mem[0], cpu.ram.mem[1], cpu.ram.mem[2], cpu.ram.mem[3]);
		//$monitor("state = %d, exec = %b, opcode = %b, sel1 = %d, sel2 = %d, shift = %d, dest = %d, source1 = %h, source2 = %h, ALU_data = %h, cond = %b , flags = %b", cpu.current_state, cpu.execute, cpu.opcode, cpu.select1, cpu.select2[3:1], cpu.select2[3:0], cpu.dest, cpu.source1, cpu.source2, cpu.ALU_data, cpu.cond, cpu.flags);
	end
endmodule

