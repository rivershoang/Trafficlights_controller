module fsm(
	input logic clk_f, // xung clock
	input logic rst_i, //active high
	input logic button_i, // nut sw dieu khien huong xe
	output logic l_red_A, // den do ben duong A
	output logic l_yellow_A, // den vang ben duong A
	output logic l_green_A, // den xanj ben duong A
	output logic l_red_B, // den do ben duong B
	output logic l_yellow_B, // den vang ben duong B
	output logic l_green_B, // den xanh ben duong B
	output logic [3:0] l_7_A, // led hien thi so giay ben duong A
	output logic [3:0] l_7_B // len hien thi so giay ben duong B
);
parameter [1:0] S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11; // cac trang thai
logic [1:0] pre_state, next_state; 
logic [3:0] C_o; // bo dem den vang 3 xuong 0
// khoi ff dat trang thai
always_ff @(posedge clk_f) begin 
	if(rst_i==0)  pre_state<=S0;  
	else  pre_state<=next_state; 
	end
// khoi count_down khi den vang
always_ff @(posedge clk_f) begin
if(pre_state==S0 || pre_state==S2) C_o<=3;
else if(pre_state==S1 || pre_state==S3) C_o<=C_o-1;
 end     
/* verilator lint_off LATCH */
always@(pre_state or button_i or C_o) begin 
 case(pre_state) 
  S0: if(button_i)  next_state = S1;  
       else  next_state=S0;  

  S1:if(C_o==0) next_state = S2;
  else next_state =S1;
  
  S2: if(!button_i)  next_state =S3; 
  		else  next_state=S2; 

  S3: if(C_o==0) next_state =S0;
  	else next_state = S3;
	
  	endcase
  	end
/* verilator lint_on LATCH */
 // khoi output 
 always_comb begin
 	case(pre_state)
 		S0: begin 
 			l_red_A=0;
 			l_yellow_A=0;
 			l_green_A=1;// den xanh huong A
 			l_red_B = 1; // den do huong B
 			l_yellow_B=0;
 			l_green_B =0;
 			l_7_A=4'b1001; // hien thi so 9 
 			l_7_B=4'b1001; // hien thi so 9
 			end
 		S1: begin
 			l_red_A= 0;
 			l_yellow_A= 1; // den vang huong A
 			l_green_A=0;
 			l_red_B= 1; // den do huong B
 			l_yellow_B=0;
 			l_green_B=0;	
			l_7_A=C_o; // hien thi 3 xuong 0 
			l_7_B=4'b1001; // hien thi so 9
 			
 			end
 		S2:  begin
 			l_red_A= 1; // den do huong A
 			l_yellow_A= 0;
 			l_green_A=0;
 			l_red_B= 0;
 			l_yellow_B=0;
 			l_green_B=1; // den xanh huong B
 			l_7_A=4'b1001; // hien thi so 9
 			l_7_B=4'b1001; // hien thi so 9
 			end
 		S3: begin 
 			l_red_A= 1; // den do huong A
 			l_yellow_A= 0;
 			l_green_A=0;
 			l_red_B= 0;
 			l_yellow_B=1; // den vang huong B
 			l_green_B=0;	
 			l_7_A=4'b1001; // hien thi so 9
 			l_7_B=C_o; // dem nguoi 3 ve 0
 			end
 		endcase 
 		end

 
 endmodule
