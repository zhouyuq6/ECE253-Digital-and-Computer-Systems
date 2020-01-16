module part3(SW,KEY,HEX0,HEX1);
	input [0:0]KEY;
	input [1:0]SW;
	output [6:0]HEX0,HEX1;
	wire [7:0]Q;
	T_FF t0(SW[0],KEY[0],SW[1],Q[0]);
	T_FF t1(SW[0],KEY[0],SW[1]&Q[0],Q[1]);
	T_FF t2(SW[0],KEY[0],SW[1]&Q[0]&Q[1],Q[2]);
	T_FF t3(SW[0],KEY[0],SW[1]&Q[0]&Q[1]&Q[2],Q[3]);
	T_FF t4(SW[0],KEY[0],SW[1]&Q[0]&Q[1]&Q[2]&Q[3],Q[4]);
	T_FF t5(SW[0],KEY[0],SW[1]&Q[0]&Q[1]&Q[2]&Q[3]&Q[4],Q[5]);
	T_FF t6(SW[0],KEY[0],SW[1]&Q[0]&Q[1]&Q[2]&Q[3]&Q[4]&Q[5],Q[6]);
	T_FF t7(SW[0],KEY[0],SW[1]&Q[0]&Q[1]&Q[2]&Q[3]&Q[4]&Q[5]&Q[6],Q[7]);
	hexdisplay h0(Q[3:0],HEX0[6:0]);
	hexdisplay h1(Q[7:4],HEX1[6:0]);
endmodule

module T_FF(clear,clk,d,q);
	input d,clear,clk;
	output reg q;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			q <= 1'b0;
		else
			q <= q ^ d;
	end
endmodule