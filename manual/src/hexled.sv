module hexled (
	input logic [3:0] l_7_A,
	input logic [3:0] l_7_B,
	output logic [6:0] led_A,
	output logic [6:0] led_B
); 
always_comb begin 
	case(l_7_A)
		4'b0000: led_A= 7'b1000000;//0
		4'b0001: led_A= 7'b1111001; // 1
		4'b0010: led_A= 7'b0100100; //2
		4'b0011: led_A= 7'b0110000; //3
		4'b0100: led_A= 7'b0011001; //4
		4'b0101: led_A= 7'b0010010; // 5
		4'b0110: led_A= 7'b0000010; //6
		4'b0111: led_A= 7'b1011000; // 7
		4'b1000: led_A= 7'b0000000; //8
		4'b1001: led_A= 7'b0010000; //9
		default: led_A= 7'b0000000; //loi
	endcase 

	case(l_7_B)
		4'b0000: led_B=  7'b1000000;//0
		4'b0001: led_B= 7'b1111001; // 1
		4'b0010: led_B= 7'b0100100; //2
		4'b0011: led_B= 7'b0110000; //3
		4'b0100: led_B= 7'b0011001; //4
		4'b0101: led_B= 7'b0010010; // 5
		4'b0110: led_B= 7'b0000010; //6
		4'b0111: led_B= 7'b1011000; // 7
		4'b1000: led_B= 7'b0000000; //8
		4'b1001: led_B = 7'b0010000; //9
		default: led_B= 7'b0000000; //loi
	endcase
	end
endmodule 
