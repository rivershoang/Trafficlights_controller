	module fsm (
	    input logic clk_f,
	    input logic rst_n, // negative 
	    input logic swap_mode, // select mode
	    input logic button, // use on manual mode
	    output logic l_red_A,
	    output logic l_yellow_A,
	    output logic l_green_A,
	    output logic l_red_B,
	    output logic l_yellow_B,
	    output logic l_green_B,
	    output logic [3:0] l_7_A,
	    output logic [3:0] l_7_B
	);
	parameter [3:0] IDLE=4'd0, S0=4'd1, S1=4'd2, S2=4'd3, S3=4'd4, S4=4'd5, S5=4'd6, S6=4'd7, S7=4'd8, S8=4'd9;
	logic [3:0] pre_state, next_state; 
	logic [3:0] C_o;
	logic [3:0] count_R;
	logic [3:0] count_G;
	logic [3:0] count_Y;
	//khoi dat trang thai ban dau 
	always_ff@(posedge clk_f) begin 
	    if(rst_n==0) pre_state<=IDLE;
	    else pre_state <=next_state; 
	end 
	//khoi tao bo dem nguoc
	always_ff @(posedge clk_f) begin
	    if(pre_state==IDLE) begin  
	    	count_R<=9;
	 		count_Y<=2;
	 		count_G<=5;
	        C_o<=3; end 
	    else if(pre_state==S0) begin count_G<=count_G-1; count_R<=count_R-1; count_Y<=2; end
	    else if(pre_state==S1) begin count_Y<=count_Y-1; count_R<=count_R-1; end
	    else if(pre_state==S2) begin count_G<=5; count_Y<=2; count_R<=8; end
	    else if(pre_state==S3) begin  count_G<=count_G-1; count_R<=count_R-1; end
	    else if(pre_state==S4) begin count_Y<=count_Y-1; count_R<=9; count_G<=5; end
	    else if(pre_state==S5 || pre_state==S7) C_o<=3;
	    else if(pre_state==S6 || pre_state==S8) C_o<=C_o-1;  
	end
	
	// khoi chuyen trang thai 
/* verilator lint_off LATCH */
	always@(pre_state or swap_mode or button or C_o or count_G or count_R or count_Y) begin
	    case(pre_state)
	        IDLE: 
	            case(swap_mode) 
	            0: next_state = S0;
	            1: next_state = S5;
	            endcase
	        S0: 
	            case(swap_mode) 
	            0: if(count_G==0 && count_R==4) next_state = S1;
	               else next_state =S0;
	            1: next_state =S5;
	            endcase
	        S1: 
	            case(swap_mode)
	            0:if(count_Y==0 && count_R==1) next_state =S2;
	              else next_state=S1;
	            1: next_state =S5;
	            endcase
	        S2: 
	            case(swap_mode)
	            0:  next_state=S3;
	            1: next_state =S5; 
	            endcase
	        S3:
	            case(swap_mode)
	            0:   if(count_G==0 && count_R==3) next_state =S4;
	                else   next_state =S3; 
	            1: next_state =S5;
	            endcase
	        S4: 
	            case(swap_mode)
	            0: if(count_Y==0) next_state =S0;
	                else next_state =S4;
	            1: next_state =S5;
	            endcase
	        
	        S5: 
	            case(swap_mode)
	            1:   if(button)  next_state = S6;  
	                else  next_state=S5;     
	            0: next_state =IDLE;
	            endcase
	        S6: 
	            case(swap_mode)
	            1: if(C_o==0) next_state = S7;
	                else next_state =S6;
	            0: next_state=IDLE;
	            endcase
	        S7:
	            case(swap_mode)
	            1:if(!button)  next_state =S8; 
	                else  next_state=S7;
	            0: next_state=S0;
	            endcase
	        S8: 
	            case(swap_mode)
	            1: if(C_o==0) next_state =S5;
	                else next_state = S8;
	            0: next_state=IDLE;
	            endcase
	        default: next_state=4'bxxxx;
	    endcase 
	end 
/* verilator lint_on LATCH */  
	//khoi output 
	always_comb begin 
	    case(pre_state) 
	       IDLE: begin 
	         l_red_A=1;
	         l_yellow_A=0;
	         l_green_A=0;
	         l_red_B= 0;
	         l_yellow_B=0;
	         l_green_B =1;
	         l_7_A=4'b0000;
	         l_7_B=4'b0000;
	        end
	        S0:  begin 
				l_red_A=1;
				l_yellow_A=0;
				l_green_A=0;
				l_red_B= 0;
				l_yellow_B=0;
				l_green_B =1;
				l_7_A= count_R;
				l_7_B= count_G;
				end
	        S1: begin 
				l_red_A=1;
				l_yellow_A=0;
				l_green_A=0;
				l_red_B= 0;
				l_yellow_B=1;
				l_green_B =0;
				l_7_A=count_R;
				l_7_B=count_Y;
				end
	        S2: begin 
	                l_red_A=1;
	                l_yellow_A=0;
	                l_green_A=0;
	                l_red_B= 1;
	                l_yellow_B=0;
	                l_green_B =0;
	                l_7_A=4'b0000;
	                l_7_B=4'b1001;
	                end	
	        S3: begin 
	                    l_red_A=0;
	                    l_yellow_A=0;
	                    l_green_A=1;
	                    l_red_B= 1;
	                    l_yellow_B=0;
	                    l_green_B =0;
	                    l_7_A=count_G;
	                    l_7_B=count_R;
	            end
	        S4: begin 
	                l_red_A=0;
	                l_yellow_A=1;
	                l_green_A=0;
	                l_red_B= 1;
	                l_yellow_B=0;
	                l_green_B =0;
	                l_7_A=count_Y;
	                l_7_B=count_Y;
	            end
	        S5: begin 
	                l_red_A=0;
	                l_yellow_A=0;
	                l_green_A=1;// den xanh huong A
	                l_red_B = 1; // den do huong B
	                l_yellow_B=0;
	                l_green_B =0;
	                l_7_A=4'b1001; // hien thi so 9 
	                l_7_B=4'b1001; // hien thi so 9
	            end
	        S6: begin
	                l_red_A= 0;
	                l_yellow_A= 1; // den vang huong A
	                l_green_A=0;
	                l_red_B= 1; // den do huong B
	                l_yellow_B=0;
	                l_green_B=0;	
	               l_7_A=C_o; // hien thi 3 xuong 0 
	               l_7_B=4'b1001; // hien thi so 9
	                
	            end
	        S7:  
	            begin
	                l_red_A= 1; // den do huong A
	                l_yellow_A= 0;
	                l_green_A=0;
	                l_red_B= 0;
	                l_yellow_B=0;
	                l_green_B=1; // den xanh huong B
	                l_7_A=4'b1001; // hien thi so 9
	                l_7_B=4'b1001; // hien thi so 9
	            end
	        S8: begin 
	                l_red_A= 1; // den do huong A
	                l_yellow_A= 0;
	                l_green_A=0;
	                l_red_B= 0;
	                l_yellow_B=1; // den vang huong B
	                l_green_B=0;	
	                l_7_A=4'b1001; // hien thi so 9
	                l_7_B=C_o; // dem nguoi 3 ve 0
	            end
	        default:begin 
	                l_red_A=1;
	                l_yellow_A=1;
	                l_green_A=1;
	                l_red_B= 1;
	                l_yellow_B=1;
	                l_green_B =1;
	                l_7_A=4'b0000;
	                l_7_B=4'b0000;
	                end 
	    endcase
	end
	endmodule
	
