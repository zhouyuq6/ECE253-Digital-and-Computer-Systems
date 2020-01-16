module part1(d,clk,qa,qb,qc);
	input d,clk;
	output reg qa;
   always @ (d,clk)
	begin
      if (clk==1'b1)
		begin
			qa <= d;
		end
	end
	
	output reg qb;
	always @ (posedge clk)
	begin
		qb <= d;
	end
	
	output reg qc;
	always @ (negedge clk)
	begin
		qc <= d;
	end
	
endmodule
//
//module pos_d_ff(d,clk,qb);
//	input d,clk;
//	output reg qb;
//	always @ (posedge clk)
//	begin
//		qb <= d;
//	end
//endmodule
//
//module neg_d_ff(d,clk,qc);
//	input d,clk;
//	output reg qc;
//	always @ (negedge clk)
//	begin
//		qc <= d;
//	end
//endmodule