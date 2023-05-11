`timescale 1ns/1ps

module flow_water_lights_sim();
	reg  clk;
	reg rst;
	reg button;
	reg [1:0] freq_set;
	wire [7:0] led;

	initial begin
		clk = 1'b0; rst = 0; button = 0;
		#100_000  button = 1; freq_set = 2'B00;
        #320_000 button = 1; freq_set = 2'B01;
        #320_000 button = 1; freq_set = 2'B10;
        #800_000 button = 1; freq_set = 2'B11;
		#1900_000 button = 1; rst = 1 ;
		#100_000 $finish;
	end
	always #10 clk = ~clk;
	
	flow_water_lights u_flow_water_lights(
	   .clk(clk),
	   .rst(rst),
	   .button(button),
	   .freq_set(freq_set),
	   .led(led)
	);
endmodule