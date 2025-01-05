module secgen (
	input logic clk,
	input logic rst,
	output logic sec
);
///////////////////////////////////////////////
parameter CLKCONST = 50000000; //clock 50 MHz
///////////////////////////////////////////////
reg [25:0] temp; // 26-bit 67M
wire tmpzr;
assign tmpzr = temp == 0;
always_ff @(posedge clk) begin
if (rst==0)
temp <= CLKCONST; //50M
else if (tmpzr)
temp <= CLKCONST;
else
temp <= temp - 1;
end
assign sec = tmpzr;
endmodule
