module alu_or_tb();
  
parameter len = 4;

wire [len-1:0] response;
wire n, c, z, v;
reg [len-1:0] a,b;
reg clk;

initial
begin
  clk = 0;
  a = 3;
  b = 3;
  #5
  a = 2;
  b = 1;
  #5
  a = 7;
  b = 0;
end

nbit_or #(len) DUT(a, b, response, n, c, z, v);
always
#5 clk = !clk;

initial 
begin
  $display("\tclk,\ta,\tb,\tresponse,\tn,\tc,\tz,\tv"); 
  $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%d", clk, a, b, response, n, c, z, v); 
end

always
#5 clk = !clk;

endmodule


