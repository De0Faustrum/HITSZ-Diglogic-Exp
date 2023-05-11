module flow_water_lights(
	input wire clk,
	input wire rst,
	input wire button,
	input wire [1:0] freq_set,
	output reg [7:0] led
	);
	parameter MAX_CNT_1 = 20'D00999;
	parameter MAX_CNT_2 = 20'D01999;
	parameter MAX_CNT_3 = 20'D04999;
	parameter MAX_CNT_4 = 20'D09999;
	reg [19:0] cnt;
	reg [7:0]  flow_ctrl;
	initial cnt = 20'D00000;
	initial flow_ctrl = 8'B00000001;
	always @(posedge clk or posedge rst) begin
		if(rst == 1 || button == 0) begin
			flow_ctrl <= 8'B00000001;
			cnt = 20'D00000;
		end

		else begin
			if(button == 1 && freq_set == 2'B00) begin
				if(cnt < MAX_CNT_1) cnt <= cnt + 1;
				else begin
					cnt <= 20'D00000;
					if (flow_ctrl == 8'B10000000) flow_ctrl <= 8'B00000001;
					else flow_ctrl <= flow_ctrl << 1;
				end
			end

			if(button == 1 && freq_set == 2'B01) begin
				if(cnt < MAX_CNT_2) cnt <= cnt + 1;
				else begin
					cnt <= 20'D00000;
					if (flow_ctrl == 8'B10000000) flow_ctrl <= 8'B00000001;
					else flow_ctrl <= flow_ctrl << 1;
				end
			end

			if(button == 1 && freq_set == 2'B10) begin
				if(cnt < MAX_CNT_3) cnt <= cnt + 1;
				else begin
					cnt <= 20'D00000;
					if (flow_ctrl == 8'B10000000) flow_ctrl <= 8'B00000001;
					else flow_ctrl <= flow_ctrl << 1;
				end
			end

			if(button == 1 && freq_set == 2'B11) begin
				if(cnt < MAX_CNT_4) cnt <= cnt + 1;
				else begin
					cnt <= 20'D00000;
					if (flow_ctrl == 8'B10000000) flow_ctrl <= 8'B00000001;
					else flow_ctrl <= flow_ctrl << 1;
				end
			end
		end
		led <= flow_ctrl;
	end

	
endmodule