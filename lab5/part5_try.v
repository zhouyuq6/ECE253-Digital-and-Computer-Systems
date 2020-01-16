module part5_try(SW,HEX0,CLOCK_50);
	input CLOCK_50;
	input [1:0]SW;
	output [6:0]HEX0;
	wire [25:0]M;
	wire [3:0]Q;
	wire enable;
	counter26 c1(SW[0],CLOCK_50,SW[1],M[25:0]);
	assign enable=(M==26'b0)?1:0;
	counter4 c2(SW[0],CLOCK_50,enable,Q[3:0]);
	dexdisplay h0(Q[3:0],HEX0[6:0]);
endmodule

module counter4(clr,clk,E,Q);
	input clk,clr,E;
	output [3:0]Q;
	T_FF_4 t1((~clr),clk,Q[3:0],E);
endmodule

module T_FF_4(clear,clk,q,E);
	input clear,clk,E;
	output reg [3:0]q;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			q <= 4'b0;
		else
		begin
			if(q==4'b1010)
				q <= 4'b0;
			else
				begin
					if(~E)
						q <= q;
					else
						q <= q + 1;
				end
		end
	end
endmodule

module counter26(clr,clk,E,Q);
	input clk,clr,E;
	output [25:0]Q;
	T_FF_26 t0((~clr),clk,Q[25:0],E);
endmodule

module T_FF_26(clear,clk,q,E);
	input clear,clk,E;
	output reg [25:0]q;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			q <= 26'b0;
		else
			begin
				if(~E)
					q <= q;
				else
					q <= q + 1;
			end
	end
endmodule
	
module dexdisplay(S,Display);
	input[3:0] S;
	output[6:0] Display;
	assign Display[0]=((S[2])&(~S[1])&(~S[0]))|((~S[3])&(~S[2])&(~S[1])&(S[0]));
	assign Display[1]=((S[2])&(~S[1])&(S[0]))|((S[2])&(S[1])&(~S[0]));
	assign Display[2]=(~S[2])&(S[1])&(~S[0]);
	assign Display[3]=(S[2]&(~S[1])&(~S[0]))|((~S[3])&(~S[2])&(~S[1])&(S[0]))|((S[2])&(S[1])&(S[0]));
	assign Display[4]=(S[0])|((S[2])&(~S[1]));
	assign Display[5]=((~S[2])&(S[1]))|((S[1])&(S[0]))|((~S[3])&(~S[2])&(S[0]));
	assign Display[6]=((~S[3])&(~S[2])&(~S[1]))|((S[2])&(S[1])&(S[0]));
endmodule