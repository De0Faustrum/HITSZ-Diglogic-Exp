module selector(
    input wire [0:0] clk, 
	input wire [7:0] r,
	input wire [2:0] rsel,
	output reg [0:0] q
	);

	always@(posedge clk or rsel or r) begin
		case(rsel)
			3'B000: q = r[0];
			3'B001: q = r[1];
			3'B010: q = r[2];
			3'B011: q = r[3];
			3'B100: q = r[4];
			3'B101: q = r[5];
			3'B110: q = r[6];
			3'B111: q = r[7];
        endcase
	end

endmodule