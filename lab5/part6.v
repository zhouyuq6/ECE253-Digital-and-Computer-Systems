module part6(SW,CLOCK_50,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input CLOCK_50;
	input [1:0]SW;
	output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	wire [25:0]M;
	wire [2:0]Q;
	wire enable;
	counter26 c1(SW[0],CLOCK_50,SW[1],M[25:0]);
	assign enable=(M==26'b0)?1:0;
	counter3 c2(SW[0],CLOCK_50,enable,Q[2:0]);
	lab3 a(Q[2:0],HEX0[6:0],HEX1[6:0],HEX2[6:0],HEX3[6:0],HEX4[6:0],HEX5[6:0]);
endmodule

module counter3(clr,clk,E,Q);
	input clk,clr,E;
	output [2:0]Q;
	T_FF_3 t1((~clr),clk,Q[2:0],E);
endmodule

module T_FF_3(clear,clk,q,E);
	input clear,clk,E;
	output reg [2:0]q;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			q <= 3'b0;
		else
		begin
			if(q==3'b110)
				q <= 3'b0;
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

module lab3(Q,Display0,Display1,Display2,Display3,Display4,Display5);
	input [2:0]Q;
	output [6:0]Display0;
	output [6:0]Display1;
	output [6:0]Display2;
	output [6:0]Display3;
	output [6:0]Display4;
	output [6:0]Display5;
	wire [1:0]Nah,d,E,I;
	wire [1:0]M0;
	wire [1:0]M1;
	wire [1:0]M2;
	wire [1:0]M3;
	wire [1:0]M4;
	wire [1:0]M5;
	assign Nah=2'b11;
	assign d=2'b00;
	assign E=2'b01;
	assign I=2'b10;
	
	mux_2bit_6to1(Q[2:0],M0,Nah[1:0],Nah[1:0],Nah[1:0],d[1:0],E[1:0],I[1:0]);
	char_7seg H0 (M0,Display5);
	mux_2bit_6to1(Q[2:0],M1,Nah[1:0],Nah[1:0],d[1:0],E[1:0],I[1:0],Nah[1:0]);
	char_7seg H1 (M1,Display4);
	mux_2bit_6to1(Q[2:0],M2,Nah[1:0],d[1:0],E[1:0],I[1:0],Nah[1:0],Nah[1:0]);
	char_7seg H2 (M2,Display3);
	mux_2bit_6to1(Q[2:0],M3,d[1:0],E[1:0],I[1:0],Nah[1:0],Nah[1:0],Nah[1:0]);
	char_7seg H3 (M3,Display2);
	mux_2bit_6to1(Q[2:0],M4,E[1:0],I[1:0],Nah[1:0],Nah[1:0],Nah[1:0],d[1:0]);
	char_7seg H4 (M4,Display1);
	mux_2bit_6to1(Q[2:0],M5,I[1:0],Nah[1:0],Nah[1:0],Nah[1:0],d[1:0],E[1:0]);
	char_7seg H5 (M5,Display0);
endmodule

module mux_2bit_6to1(S,M,N0,N1,N2,N3,N4,N5);
	input [2:0]S;
	input [1:0]N0,N1,N2,N3,N4,N5; 
	output [1:0]M;
	reg [1:0]M;
	always @(N0 or N1 or N2 or N3 or N4 or N5 or S)
	begin
		case (S)
			3'b000: M=N0;
			3'b001: M=N1;
			3'b010: M=N2;
			3'b011: M=N3;
			3'b100: M=N4;
			3'b101: M=N5;
			default: M=8'bx;
		endcase
	end
 endmodule 
 
module char_7seg (C,Display);
  input [1:0] C;
   output [6:0] Display;
  wire a,b,c,d;
  assign a = ~C[0] & ~C[1];
  assign b = C[0] & ~C[1];
  assign c = ~C[0] & C[1];
  assign d = C[0] & C[1];
  assign Display[0] = ~b;
  assign Display[1] = ~(a|c);
  assign Display[2] = ~(a|c);
  assign Display[3] = ~(a|b);
  assign Display[4] = ~(a|b);
  assign Display[5] = ~b;
  assign Display[6] = ~(a|b);
endmodule