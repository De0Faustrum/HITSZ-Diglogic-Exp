`timescale 1ns/1ps

module reg8file_sim();
	reg  [0:0] clk;
	wire [0:0] clr;
	wire [0:0] enable;
	wire [7:0] d;
	wire [2:0] wsel;
	wire [2:0] rsel;
	wire [0:0] q;
    reg  [15:0] switch;
    
	initial begin
		clk = 1'b0;
		#0  switch = 16'B0_0_10101010_000_000; 
		#20 switch = 16'B1_0_10101010_000_000;		//Enable
		#20 switch = 16'B1_0_10101010_001_001;
		#20 switch = 16'B1_0_10101010_010_010;
		#20 switch = 16'B1_0_10101010_011_011;
		#20 switch = 16'B1_0_10101010_100_100;
		#20 switch = 16'B1_0_10101010_101_101;
		#20 switch = 16'B1_0_10101010_110_110;
		#20 switch = 16'B1_0_10101010_111_111;		//Initialize above
		#20 switch = 16'B1_0_10101010_111_110;		//Test for selector
		#20 switch = 16'B1_0_10101010_111_101;
		#20 switch = 16'B1_0_10101010_111_100;
		#20 switch = 16'B1_0_10111010_111_100;		//Test for Latch function(测试锁存功能)
		#20 switch = 16'B1_0_10111010_100_100;		//Test for DFF function(测试锁存功能)
		#20 switch = 16'B1_1_10111010_111_111;		//Reset to ZERO
		#20 $finish;
	end
	always #10 clk = ~clk;
	
	assign {enable,clr,d,wsel,rsel} = switch;
	
	reg8file u_reg8file(
	   .clk(clk),
	   .clr(clr),
	   .enable(enable),
	   .d(d),
	   .wsel(wsel),
	   .rsel(rsel),
	   .r(r),
	   .q(q)
	);
endmodule