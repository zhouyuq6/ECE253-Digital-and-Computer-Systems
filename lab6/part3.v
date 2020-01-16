module part3(SW,LEDR,KEY,CLOCK_50);
	input [3:0]SW;
	input [1:0]KEY;
	input CLOCK_50;
	output [1:0]LEDR;
	wire [2:0] Len;// Length of each morse code 
	wire [3:0] M;//Morse code
	wire clk,E;//half sec clk and enable for clock
	reg [3:0]Q; //
	reg [2:0] PS,NS,cnt; //present state, next state and a counter;
	reg z;
	parameter a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100;//use to represent states 

	assign LEDR[0]=z;
	assign E=1'b1;
	counter25 half(SW[3],CLOCK_50,E,clk);//half sec counter
	letter m1(SW[2:0],M[3:0],Len);//Letter translator
//	shift_reg m2(clk,PS,M,Q);
//	len_cnt m3(clk,PS,Len,cnt);

	always @(Q[3], KEY[1:0], cnt, PS) //FSM
	begin: state_table
		case (PS)
			a: if (!KEY[1]) NS = b; 
				else NS = a; 
			b: if (!Q[3]) NS = e; 
				else NS = c; 
			c: if (!KEY[0]) NS = a;
				else NS = d;
			d: if (!KEY[0]) NS = a; 
				else NS = e;
			e: if (cnt == 3'b001) NS = a;
				else NS = b;
		default: NS = 3'bxxx; 
		endcase
	end

	
	always@(posedge CLOCK_50)
	begin
		if(!KEY[0])
			PS <= a;
		else
		begin
			if(clk)
				PS <= NS;
		end
	end
	
	always @(PS)
	begin: light_assign
		case (PS)
			b: z = 1'b1;
			c: z = 1'b1;
			d: z = 1'b1; 
			default: z = 1'b0; 
		endcase
	end

	//Length counter
	always@(posedge CLOCK_50)
	begin:length_cnt
		if(PS==a)
			cnt<=Len;
		else
			begin
				if(clk)
				begin
					if(PS==e)
						cnt = cnt-1;
				end
			end
	end
	
	//shift Register
	always@(posedge CLOCK_50)
	begin:shift_reg
		if(PS==a)
			Q<=M;
		else
			begin
				if(clk)
				begin
					if(PS==e)
					begin
						Q[3] <= Q[2]; 
						Q[2] <= Q[1];  
						Q[1] <= Q[0]; 
						Q[0] <= 1'b0; 
					end
				end
			end
	end
endmodule

module letter(PS,NS,Len); //Letter to Morse codes
	input [2:0]PS;
	output reg [3:0]NS;
	output reg [2:0]Len;
	parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101, G=3'b110, H=3'b111;//input SW patterns
	parameter Ma=4'b01xx, Mb=4'b1000, Mc=4'b1010, Md=4'b100x, Me=4'b0xxx, Mf=4'b0010, Mg=4'b110x, Mh=4'b0000;//Translation to morse codes
	always@(*)
	begin:letter_translation
		case(PS)
			A:begin
				NS<=Ma;
				Len=3'b010;
				end
			B:begin
				NS<=Mb;
				Len=3'b100;
				end
			C:begin
				NS<=Mc;
				Len=3'b100;
				end
			D:begin
				NS<=Md;
				Len=3'b011;
				end
			E:begin
				NS<=Me;
				Len=3'b001;
				end
			F:begin
				NS<=Mf;
				Len=3'b100;
				end
			G:begin
				NS<=Mg;
				Len=3'b011;
				end
			H:begin
				NS<=Mh;
				Len=3'b100;
				end
			default: NS<=4'bxxxx;
		endcase
	end
endmodule

module counter25(clr,clk,E,cnt); //half  second counter
	input clk,clr,E;
	output cnt;
	wire [24:0]Q;
	T_FF_25 t0((~clr),clk,Q[24:0],E);
	assign cnt=(Q==25'b0)?1:0;
endmodule

module T_FF_25(clear,clk,q,E);
	input clear,clk,E;
	output reg [24:0]q;
	always@(posedge clk, negedge clear)
	begin
		if(~clear)
			q <= 25'b0;
		else
			begin
				if(~E)
					q <= q;
				else
					q <= q + 1;
			end
	end
endmodule