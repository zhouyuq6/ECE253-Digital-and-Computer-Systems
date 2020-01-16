module part2(SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,KEY,LEDR);
	input [7:0]SW;
	input [1:0]KEY;
	output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	output [8:0]LEDR;
	wire [7:0]A,B,S;
	eight_bit ain(KEY[0],KEY[1],SW[7:0],A[7:0]);
	eight_bit bin(KEY[0],KEY[1],SW[7:0],B[7:0]);
	adder sum(A,B,S,LEDR);
	hexdisplay ah(A[7:4],HEX3[6:0]);
	hexdisplay al(A[3:0],HEX2[6:0]);
	hexdisplay bh(B[7:4],HEX1[6:0]);
	hexdisplay bl(B[3:0],HEX0[6:0]);	
	hexdisplay sh(S[7:4],HEX5[6:0]);
	hexdisplay sl(S[3:0],HEX4[6:0]);
endmodule

module eight_bit(Reset,Clk,D,A);
	input Reset,Clk;
	input [7:0]D;
	output [7:0]A;
	asy_reset a0(Reset,Clk,D[0],A[0]);
	asy_reset a1(Reset,Clk,D[1],A[1]);
	asy_reset a2(Reset,Clk,D[2],A[2]);
	asy_reset a3(Reset,Clk,D[3],A[3]);
	asy_reset a4(Reset,Clk,D[4],A[4]);
	asy_reset a5(Reset,Clk,D[5],A[5]);
	asy_reset a6(Reset,Clk,D[6],A[6]);
	asy_reset a7(Reset,Clk,D[7],A[7]);
endmodule

module asy_reset(reset,clk,D,Q);
	input D,reset,clk;
	output reg Q;
	always@(posedge clk or negedge reset)
	begin
		if(~reset)
			Q<=1'b0;
		else
			Q<=D;
	end
endmodule

module hexdisplay(S,Display);
	input [3:0]S;
	output [6:0]Display;
	assign Display[0]=((~S[3])&(~S[2])&(~S[1])&(S[0]))|((~S[3])&(S[2])&(~S[1])&(~S[0]))|((S[3])&(~S[2])&(S[1])&(S[0]))|((S[3])&(S[2])&(~S[1])&(S[0]));
	assign Display[1]=((S[2])&(S[1])&(~S[0]))|((S[3])&(S[1])&(S[0]))|((S[3])&(S[2])&(~S[0]))|((~S[3])&(S[2])&(~S[1])&(S[0]));
	assign Display[2]=((S[3])&(S[2])&(~S[0]))|((S[3])&(S[2])&(S[1]))|((~S[3])&(~S[2])&(S[1])&(~S[0]));
	assign Display[3]=(S[2]&(S[1])&(S[0]))|((~S[3])&(~S[2])&(~S[1])&(S[0]))|((~S[3])&(S[2])&(~S[1])&(~S[0]))|((S[3])&(~S[2])&(S[1])&(~S[0]));
	assign Display[4]=((~S[3])&(S[0]))|((~S[2])&(~S[1])&(S[0]))|((~S[3])&(S[2])&(~S[1]));
	assign Display[5]=((~S[3])&(~S[2])&(S[0]))|((~S[3])&(~S[2])&(S[1]))|((~S[3])&(S[1])&(S[0]))|((S[3])&(S[2])&(~S[1])&(S[0]));
	assign Display[6]=((~S[3])&(~S[2])&(~S[1]))|((~S[3])&(S[2])&(S[1])&(S[0]))|((S[3])&(S[2])&(~S[1])&(~S[0]));
endmodule

module adder(A,B,SUM,carry);
	input [7:0]A,B;
	output [8:0]SUM;
	output [8:0] carry;
	assign carry[0]=1'b0;
	full_adder u1(A[0],B[0],carry[0],SUM[0],carry[1]);
	full_adder u2(A[1],B[1],carry[1],SUM[1],carry[2]);
	full_adder u3(A[2],B[2],carry[2],SUM[2],carry[3]);
	full_adder u4(A[3],B[3],carry[3],SUM[3],carry[4]);
	full_adder u5(A[4],B[4],carry[4],SUM[4],carry[5]);
	full_adder u6(A[5],B[5],carry[5],SUM[5],carry[6]);
	full_adder u7(A[6],B[6],carry[6],SUM[6],carry[7]);
	full_adder u8(A[7],B[7],carry[7],SUM[7],carry[8]);
endmodule

module full_adder(a,b,cin,s,cout);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	assign s=a^b^cin;
	assign cout=((a^b)&(cin))|((~(a^b))&(b));
endmodule
