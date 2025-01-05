module secgen (
    input logic rst,
    input logic clk,
    output logic sec
);
parameter CLKCONST = 50000000;
reg [25:0] temp;
wire tmpzr;
assign tmpzr =temp ==0; 
always_ff@(posedge clk) begin 
    if(rst==0) temp <=CLKCONST; 
    else if(tmpzr) temp <=CLKCONST;
    else temp<=temp-1;
end 
assign sec=tmpzr;
endmodule 