module part1_new(SW,LEDR,KEY);
	input [1:0]SW;
	input [0:0]KEY;
	output [9:0]LEDR;
	wire [8:0]PS,NS;
	fsm_helper_new h(NS[8:0],PS[8:0],SW[1],LEDR[9]);
	T_FF_9_new t(SW[0],KEY[0],PS[8:0],NS[8:0]);
	assign LEDR[8:0]=PS[8:0];
endmodule
	

module fsm_helper_new(Y,y,w,z);
	input [8:0]y;
	input w;
	output [8:0]Y;
	output z;
	assign Y[8]=w&(y[7]|y[8]);
	assign Y[7]=w&y[6];
	assign Y[6]=w&y[5];
	assign Y[5]=w&((~y[0])|y[1]|y[2]|y[3]|y[4]);
	assign Y[4]=(~w)&(y[3]|y[4]);
	assign Y[3]=(~w)&y[2];
	assign Y[2]=(~w)&y[1];
	assign Y[1]=(~w)&((~y[0])|y[5]|y[6]|y[7]|y[8]);
	assign Y[0]=9'b111111111;
	assign z=y[4]|y[8];
endmodule

module T_FF_9_new(clear,clk,PS,NS);
	input clear,clk;
	input [8:0]NS;
	output reg [8:0]PS;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			PS <= 9'b000000000;
		else
			PS <= NS;
	end
endmodule
