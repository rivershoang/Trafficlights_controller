module full (
    input logic clk_i,
    input logic rst,
    input logic swap_mode_i,
    input logic button_i,
    output logic l_red_A,
    output logic l_yellow_A,
    output logic l_green_A,
    output logic l_red_B,
    output logic l_yellow_B,
    output logic l_green_B,
    output logic [6:0] led_A,
    output logic [6:0] led_B
);
logic X;
logic [3:0] Y;
logic [3:0] Z;
secgen secgen_dut(
    .clk(clk_i),
    .rst(rst),
    .sec(X)
);
fsm fsm_dut (
    .clk_f(X),
    .swap_mode(swap_mode_i),
    .button(button_i),
    .rst_n(rst),
    .l_red_A(l_red_A),
    .l_green_A(l_green_A),
    .l_yellow_A(l_yellow_A),
    .l_red_B(l_red_B),
    .l_yellow_B(l_yellow_B),
    .l_green_B(l_green_B),
    .l_7_A(Y),
    .l_7_B(Z)
);
hexled hexled_dut (
    .l_7_A(Y),
    .l_7_B(Z),
    .led_A(led_A),
    .led_B(led_B)
);  
endmodule 