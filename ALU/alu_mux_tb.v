module alu_mux_tb();

wire [31:0] response;
reg [31:0] k, l, m, n, o, p, q, r, s, t;
reg [3:0] select;
reg clk;

initial
begin
  clk = 0;
  k = 8'habcdefab;
  l = 8'h0f0f0f0f;
  s = 8'hffffffff;
  #5
  select = 0;
  #5
  select = 1;
  #5
  select = 8;
end

mux DUT(k, l, m, n, o, p, q, r, s, t, select, response);
always
#5 clk = !clk;

initial 
begin
  $display("\tclk,\ta,\tb,\ti,\tselect,\tresponse"); 
  $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%b,\t%d", clk, k, l, s, select, response); 
end

always
#5 clk = !clk;

endmodule




