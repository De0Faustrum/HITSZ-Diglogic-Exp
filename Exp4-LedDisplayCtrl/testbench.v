`timescale 1ns/1ps

module flow_water_lights_sim();

	reg rst;
	reg button;
	reg counter;
	reg clk;
	wire stabilizer_;
	wire led_ca;
	wire led_cb;
	wire led_cc;
	wire led_cd;
	wire led_ce;
	wire led_cf;
	wire led_cg;
	wire led_dp;
	wire [7:0] led_en;

	initial begin
		clk = 1'b0; rst = 0; button = 0;
		#0  button = 0; counter = 0;
		#2_000_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#50_00   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#20_000_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
		#500_0   button = 1; counter = 1;
		#500_0   button = 1; counter = 0;
        #80_0000  button = 1; counter = 1;
		#20_000_0   rst = 1;
		#3_000_0    $finish;
	end
	always #10 clk = ~clk;
	
	led_display_ctrl u_led_display_ctrl(
	   .clk(clk),
	   .rst(rst),
	   .button(button),
	   .counter(counter),
	   .led_ca(led_ca),
	   .led_cb(led_cb),
	   .led_cc(led_cc),
	   .led_cd(led_cd),
	   .led_ce(led_ce),
	   .led_cf(led_cf),
	   .led_cg(led_cg),
	   .led_dp(led_dp),
	   .led_en(led_en),
	   .stabilizer_(stabilizer_)
	);
endmodule