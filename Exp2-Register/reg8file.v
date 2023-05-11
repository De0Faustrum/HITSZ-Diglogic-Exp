module reg8file(
	input wire [0:0] clk,
	input wire [0:0] clr,
	input wire [0:0] enable,
	input wire [7:0] d,
	input wire [2:0] wsel,
	input wire [2:0] rsel,
	output reg [0:0] q
 	)

 	reg [7:0] en; 
 	reg [7:0] r;

	decoder decoder(
		.enable (enable),
		.wsel (wsel),
		.en (en)
	)

	selector selector(
		.r (r),
		.rsel (rsel),
		.q (q)
	)

	dff dff_0(
		.en(en[0]),
		.d(d[0]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_1(
		.en(en[1]),
		.d(d[1]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_2(
		.en(en[2]),
		.d(d[2]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_3(
		.en(en[3]),
		.d(d[3]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_4(
		.en(en[4]),
		.d(d[4]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_5(
		.en(en[5]),
		.d(d[5]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_6(
		.en(en[6]),
		.d(d[6]),
		.clk(clk),
		.clr(clr)
		)
	dff dff_7(
		.en(en[7]),
		.d(d[7]),
		.clk(clk),
		.clr(clr)
		)
endmodule