module part4(SW,KEY,HEX0,HEX1,HEX2,HEX3);
	input [0:0]KEY;
	input [1:0]SW;
	output [6:0]HEX0,HEX1,HEX2,HEX3;
	wire [15:0]Q;
	T_FF_p4 t0(SW[0],KEY[0],Q[15:0],SW[1]);
	hexdisplay h0(Q[3:0],HEX0[6:0]);
	hexdisplay h1(Q[7:4],HEX1[6:0]);
	hexdisplay h2(Q[11:8],HEX2[6:0]);
	hexdisplay h3(Q[15:12],HEX3[6:0]);
endmodule

module T_FF_p4(clear,clk,q,E);
	input clear,clk,E;
	output reg [15:0]q;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			q <= 16'b0;
		else
			begin
				if(~E)
					q <= q;
				else
					q <= q + 1;
			end
	end
endmodule