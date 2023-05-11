module dff(
	input wire [0:0] clk,
	input wire [0:0] clr,
	input wire [0:0] en,
	input wire [0:0] d,
	output reg [0:0] q
);
	initial begin
	   q = 0;
	end
	always@(posedge clk or posedge clr) begin
		if(clr == 1) begin 
			q <= 0;
		end
		else begin
			if(en == 1)
				q <= d;
			else 
				q <= q;
		end
	end

endmodule