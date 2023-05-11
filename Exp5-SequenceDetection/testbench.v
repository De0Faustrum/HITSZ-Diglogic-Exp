`timescale 1ns/1ps

module sequence_detection_sim();
	reg clk;
	reg rst;
	reg button;
	reg [7:0] switch;
	wire led;

	initial begin
		clk = 1'b0; rst = 0; button = 0;
		#5  switch = 8'B01101011;
		#5 button = 1;
		#10 button = 0;
		#25 switch = 8'B11001100;
		#5 button = 1;
		#10 button = 0;
		#25 switch = 8'B00110100;
		#5 button = 1;
		#10 button = 0;
		#25 rst = 1;
		#10 $finish;
	end
	always #10 clk = ~clk;
	
	sequence_detection u_sequence_detection(
	   .clk(clk),
	   .rst(rst),
	   .button(button),
	   .switch(switch),
	   .led(led)
	);
endmodule