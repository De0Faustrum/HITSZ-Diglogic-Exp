module decoder(
	input wire [2:0] wsel,
	input wire [0:0] enable,
	output reg [7:0] en
	);
	initial begin
		en = 8'B00000000;
	end

	always@(*) begin
		if(enable == 1) begin
			case(wsel)
				3'B000: en = 8'B00000001; 
				3'B001: en = 8'B00000010;
				3'B010: en = 8'B00000100;
				3'B011: en = 8'B00001000;
				3'B100: en = 8'B00010000;
				3'B101: en = 8'B00100000;
				3'B110: en = 8'B01000000;
				3'B111: en = 8'B10000000;
			endcase	
		end
		else en = 8'B00000000; 
	end

endmodule