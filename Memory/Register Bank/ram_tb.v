`include "RAM.v"

module ram_tb();

reg clock;
reg[1:0] state;
reg[2:0] enable; 
reg [15:0] dataIn;
reg [2:0] sel;

wire [15:0] source1, source2;

RAM r(enable, sel, dataIn, source1, source2, state);
  
initial
  begin
  
	$dumpfile("ram_test.vcd");
    $dumpvars(0,ram_tb);
  
	$readmemh("initial_ram_data.txt", r.mem);
    clock = 0;
	state = 0;
	enable = 0;
	sel = 0;
	dataIn = 0;
	
	#30
	
	
	enable = 1;
	
	#20
	
	sel = 1;
	
	#20
	
	dataIn = 16'hAAAA;
	
	enable = 7;
	
	#20
	
	sel = 7;
	
	
	
	$finish();
	
   end

always@(posedge clock)
	begin
	
	if (state==2)
		state =0;
	else
		state = state +1;
	end
	
always
	begin
	clock = ~clock;
	#5;
	end
	
initial 
	begin
	
	$monitor("clock =%d, time =%d, state =%d, enable = %b, dataIn =%h, sel = %b, dataOut=%h", clock, $time, state, enable, dataIn, sel, dataOut);
	
	end
endmodule



		