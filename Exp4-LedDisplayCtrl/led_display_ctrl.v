module led_display_ctrl(
	input wire rst,
	input wire button,
	input wire counter,
	input wire clk,
	output reg led_ca,
	output reg led_cb,
	output reg led_cc,
	output reg led_cd,
	output reg led_ce,
	output reg led_cf,
	output reg led_cg,
	output reg led_dp,
	output reg [7:0] led_en,
	output reg [0:0] stabilizer_
	);
	reg [0:0]  empower;
	reg [7:0]  counter_cnt;
	reg [31:0] anti_stabilizer;
    reg [31:0] stabilizer;
	reg [31:0] refresh_cnt;
	reg [31:0] cnt;
	reg [7:0]  cnter;
	parameter MAX_2MS = 32'D00000099;
	parameter MAX_TIMER = 32'D00004999;
	parameter MAX_200MS = 32'D00000799;
	parameter CNT_CELL = 8'H21;
	parameter LED_0 = 8'H03;
	parameter LED_1 = 8'H9F;
	parameter LED_2 = 8'H25;
	parameter LED_3 = 8'H0D;
	parameter LED_4 = 8'H99;
	parameter LED_5 = 8'H49;
	parameter LED_6 = 8'H41;
	parameter LED_7 = 8'H1F;
	parameter LED_8 = 8'H01;
	parameter LED_9 = 8'H09;
	parameter LED_A = 8'H11;
	parameter LED_B = 8'HC1;
	parameter LED_C = 8'HE5;
	parameter LED_D = 8'H85;
	parameter LED_E = 8'H61;
	parameter LED_F = 8'H71;

    initial stabilizer_ = 0;
    initial counter_cnt = 8'H00;
    initial stabilizer = 32'D00000000;
    initial anti_stabilizer = MAX_TIMER;
	initial refresh_cnt = 32'D00000000;
	initial cnt = 32'D00000000;
	initial led_en = 8'B11111110;
	initial cnter = 8'H00;
	initial empower = 1'B0;
    
    always@(posedge clk) begin
        if(rst == 1)
            empower <= 0;
        if(button == 1 && rst == 0)
            empower <= 1;
    end

	always@(posedge clk or posedge rst) begin
		if(rst == 1 || empower == 0) begin
			refresh_cnt <= 32'D00000000;
			led_en <= 8'B11111111;
		end
		else begin
			if(refresh_cnt < MAX_2MS) begin
				refresh_cnt <= refresh_cnt + 1;
			end
			else begin
				refresh_cnt <= 32'D00000000;
				case(led_en)
				    8'B11111110: led_en <= 8'B11111101;
				    8'B11111101: led_en <= 8'B11111011;
				    8'B11111011: led_en <= 8'B11110111;
				    8'B11110111: led_en <= 8'B11101111;
				    8'B11101111: led_en <= 8'B11011111;
				    8'B11011111: led_en <= 8'B10111111;
				    8'B10111111: led_en <= 8'B01111111;
				    8'B01111111: led_en <= 8'B11111110;
				    default:     led_en <= 8'B11111110;
				endcase
			end
		end
	end

	always@(posedge clk or posedge rst) begin
		if(rst == 1) begin
			cnt <= 32'D00000000;
		end
		else begin
			if(cnt < MAX_200MS) begin
				cnt <= cnt + 1;
			end
			else begin
				cnt <= 32'D00000000;
				if(cnter < CNT_CELL) begin
					cnter <= cnter + 1;
				end
				else begin
					cnter <= 8'H00;
				end
			end
		end
	end
	
	always@(posedge clk or posedge rst or posedge counter) begin
        if(rst == 1) begin
			counter_cnt <= 8'H00;
			stabilizer <= 32'D00000000;
		end
		else begin
		  if(counter == 1) begin
		      anti_stabilizer <= MAX_TIMER;
		      if(stabilizer < MAX_TIMER) begin
		          stabilizer <= stabilizer + 1;
		      end
		      else begin
		          stabilizer <= 32'D00000000;
		          stabilizer_ <= 1'B1;
		          if(counter_cnt < CNT_CELL) 
		              counter_cnt <= counter_cnt + 1;
		          else
		              counter_cnt <= 8'H00;
		      end
		  end
		  else begin
		      stabilizer <= 32'D00000000;
		      if(anti_stabilizer > 0) begin
		          anti_stabilizer <= anti_stabilizer - 1;
		      end
		      else begin
		          anti_stabilizer <= MAX_TIMER;
		          stabilizer_ <= 1'B0;
		      end
		  end
		end
	end

	always@(posedge clk) begin
	        if(empower == 1) begin
                case(led_en)
                    8'B11111110: begin
                        {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_5;
                    end
                    8'B11111101: begin
                        {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                    end
                    8'B11111011: begin
                        {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_3;
                    end
                    8'B11110111: begin
                        {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                    end
                    8'B11101111: begin
                       case(counter_cnt)
                            8'H00: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H01: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H02: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_2;
                            8'H03: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_3;
                            8'H04: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_4;
                            8'H05: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_5;
                            8'H06: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_6;
                            8'H07: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_7;
                            8'H08: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_8;
                            8'H09: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_9;
                            8'H0A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_A;
                            8'H0B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_B;
                            8'H0C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_C;
                            8'H0D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_D;
                            8'H0E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_E;
                            8'H0F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_F;
                            8'H10: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H11: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H12: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_2;
                            8'H13: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_3;
                            8'H14: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_4;
                            8'H15: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_5;
                            8'H16: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_6;
                            8'H17: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_7;
                            8'H18: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_8;
                            8'H19: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_9;
                            8'H1A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_A;
                            8'H1B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_B;
                            8'H1C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_C;
                            8'H1D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_D;
                            8'H1E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_E;
                            8'H1F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_F;
                            8'H20: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            
                        endcase
                    end
                    8'B11011111: begin
                        case(counter_cnt)
                            8'H00: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H01: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H02: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H03: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H04: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H05: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H06: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H07: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H08: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H09: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H10: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H11: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H12: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H13: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H14: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H15: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H16: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H17: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H18: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H19: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H20: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_2;
                        endcase
                    end
                    8'B10111111: begin
                        case(cnter)
                            8'H00: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H01: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H02: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_2;
                            8'H03: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_3;
                            8'H04: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_4;
                            8'H05: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_5;
                            8'H06: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_6;
                            8'H07: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_7;
                            8'H08: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_8;
                            8'H09: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_9;
                            8'H0A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_A;
                            8'H0B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_B;
                            8'H0C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_C;
                            8'H0D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_D;
                            8'H0E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_E;
                            8'H0F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_F;
                            8'H10: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H11: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H12: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_2;
                            8'H13: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_3;
                            8'H14: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_4;
                            8'H15: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_5;
                            8'H16: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_6;
                            8'H17: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_7;
                            8'H18: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_8;
                            8'H19: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_9;
                            8'H1A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_A;
                            8'H1B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_B;
                            8'H1C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_C;
                            8'H1D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_D;
                            8'H1E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_E;
                            8'H1F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_F;
                            8'H20: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                        endcase
                    end
                    8'B01111111:begin
                        case(cnter)
                            8'H00: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H01: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H02: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H03: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H04: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H05: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H06: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H07: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H08: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H09: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H0F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_0;
                            8'H10: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H11: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H12: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H13: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H14: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H15: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H16: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H17: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H18: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H19: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1A: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1B: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1C: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1D: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1E: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H1F: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_1;
                            8'H20: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} <= LED_2;
                        endcase
                    end
                endcase
			end
			else begin 
			     {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,led_dp} = 8'HFF;
			end
	end
endmodule
