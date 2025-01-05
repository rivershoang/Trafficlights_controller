module tong_hop (
	input logic clk_i,
	input logic button,
	input logic rst,
	output logic l_red_A,
	output logic l_yellow_A,
	output logic l_green_A,
	output logic l_red_B,
	output logic l_yellow_B,
	output logic l_green_B,
	output logic [6:0] led_A,
	output logic [6:0] led_B
);
logic X; // clk 
logic [3:0] Z; // bcd sang led
logic [3:0] W; // bcd sang led

secgen secgen_dut (
	.clk(clk_i),
	.rst(rst),
	.sec(X)
);

fsm fsm_dut(
	.clk_f(X),
	.rst_i(rst),
	.button_i(button),
	.l_red_A(l_red_A),
	.l_yellow_A(l_yellow_A),
	.l_green_A(l_green_A),
	.l_red_B(l_red_B),
	.l_yellow_B(l_yellow_B),
	.l_green_B(l_green_B),
	.l_7_A(Z),
	.l_7_B(W)
);
hexled hexled_dut(
	.l_7_A(Z),
	.l_7_B(W),
	.led_A(led_A),
	.led_B(led_B)
);


endmodule 
