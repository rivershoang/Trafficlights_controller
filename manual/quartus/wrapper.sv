module wrapper (
	input logic CLOCK_50,
	input logic  [0:0]KEY,
	input logic  [1:1] SW,
	output logic [19:0] GPIO_0
);

tong_hop tong_hop_dut(
	.clk_i(CLOCK_50),
	.rst(KEY[0]),
	.l_red_A(GPIO_0[0]),
	.l_yellow_A(GPIO_0[1]),
	.l_green_A(GPIO_0[2]),
	.l_red_B(GPIO_0[3]),
	.l_yellow_B(GPIO_0[4]),
	.l_green_B(GPIO_0[5]),
	.led_A(GPIO_0[12:6]),
	.led_B(GPIO_0[19:13])
);
endmodule
