module wrapper (
    input logic CLOCK_50,
    input logic  [0:0]KEY,
    input logic  [1:0] SW,
    output logic [23:0] GPIO_0
	 
); 
full full_dut(
    .clk_i(CLOCK_50),
    .rst(KEY[0]),
    .swap_mode_i(SW[0]),
    .button_i(SW[1]),
    .l_red_A(GPIO_0[0]),
	.l_yellow_A(GPIO_0[1]),
	.l_green_A(GPIO_0[2]),
	.l_red_B(GPIO_0[3]),
	.l_yellow_B(GPIO_0[4]),
	.l_green_B(GPIO_0[5]),
    .led_A(GPIO_0[16:10]),
    .led_B(GPIO_0[23:17])
); 
endmodule