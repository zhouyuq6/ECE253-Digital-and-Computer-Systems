module part2(SW,LEDR,KEY);
	input [1:0]SW;
	input [0:0]KEY;
	output [9:0]LEDR;
	reg [3:0]NS,PS;
	parameter A=4'b0000;
	parameter B=4'b0001;
	parameter C=4'b0010;
	parameter D=4'b0011;
	parameter E=4'b0100;
	parameter F=4'b0101;
	parameter G=4'b0110;
	parameter H=4'b0111;
	parameter I=4'b1000;
	
	always@(SW[1],PS)
	begin
		case(PS)
			A:if(~SW[1])NS<=B;
				else NS<=F; 
			B:if(~SW[1])NS<=C;
				else NS<=F;
			C:if(~SW[1])NS<=D;
				else NS<=F;
			D:if(~SW[1])NS<=E;
				else NS<=F;
			E:if(~SW[1])NS<=E;
				else NS<=F;
			F:if(~SW[1])NS<=B;
				else NS<=G;
			G:if(~SW[1])NS<=B;
				else NS<=H;
			H:if(~SW[1])NS<=B;
				else NS<=I;
			I:if(~SW[1])NS<=B;
				else NS<=I;
			default: NS<=4'bxxxx;
		endcase
	end
	
	always@(posedge KEY[0])
	begin
		if(~SW[0])
			PS <= A;
		else
			PS <= NS;
	end
	
	assign LEDR[9]=(PS==E)|(PS==I);
	assign LEDR[3:0]=PS[3:0];
endmodule
