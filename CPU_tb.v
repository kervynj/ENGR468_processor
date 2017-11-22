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
		
		
		$readmemb("program_instructions.txt", cpu.rom.mem); // intialize ROM memory
		
		
		for(i=0; i<16; i = i+1)
		begin	
			$display("rom-data[%d] = %h", i, cpu.rom.mem[i]);
		end
		
		
		
		$readmemh("initial_ram_data.txt", cpu.ram.mem); // initialize RAM memory 
		
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
		$monitor("clock =%b, state = %d, opcode = %b, sel1 = %d, sel2 = %d, dest = %d, source1 = %h, source2 = %h, ALU_data = %h", clock, cpu.current_state, cpu.opcode, cpu.select1, cpu.select2[3:1], cpu.dest, cpu.source1, cpu.source2, cpu.ALU_data);
	end
endmodule

