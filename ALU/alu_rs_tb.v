module alu_rs_tb();
  
parameter len = 4;
parameter shift = 2;

wire [len-1:0] response;
wire n, c, z, v;
reg [len-1:0] a;
reg clk;

initial
begin
  clk = 0;
  a = 15;
  #5
  a = 7;
  #5
  a = 1;
end

nbit_right_shift #(len, shift) DUT(a, response, n, c, z, v);
always
#5 clk = !clk;

initial 
begin
  $display("\tclk,\ta,\tresponse,\tn,\tc,\tz,\tv"); 
  $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%d", clk, a, response, n, c, z, v); 
end

always
#5 clk = !clk;

endmodule




