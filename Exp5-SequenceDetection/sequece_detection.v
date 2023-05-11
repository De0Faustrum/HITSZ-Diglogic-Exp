module sequence_detection(
	input wire clk,
	input wire rst,
	input wire button,
	input wire [7:0] switch,
	output reg led
	);

	parameter Mode_string = 5'B01011;
	reg [7:0] Current_state;   //Store Current State, alters only when button is being pressed. 
	reg [3:0] Bit_buffer;      //Store matching status.
	reg [0:0] Buffer;          //Store led status, when clock edge comes, assign to led output.

	initial begin
		Current_state = 8'B00000000;
		Buffer = 1'B0;
		Bit_buffer = 4'B0000;
	end

	always @(posedge clk) begin
		if(rst == 0 && button == 1) begin
			Current_state <= switch;
		end
	end            //Module 1, describes the shifting of status from last to current.

	always @(*) begin
	    Bit_buffer = 0;
		if(rst == 0) begin
			if(Current_state[4:0] == 5'B11010)
				Bit_buffer[0] = 1;
			if(Current_state[5:1] == 5'B11010)
				Bit_buffer[1] = 1;
			if(Current_state[6:2] == 5'B11010)
				Bit_buffer[2] = 1;
			if(Current_state[7:3] == 5'B11010)
				Bit_buffer[3] = 1;
		end
		else
		  Bit_buffer = 0;
	end            //Module 2, describes the condition for status transmission.

	always @(Bit_buffer) begin
        led = 1'B0;
		if(Bit_buffer[0] == 1 || Bit_buffer[1] == 1
		       || Bit_buffer[2] == 1 || Bit_buffer[3] == 1)
			led = 1'B1;
		else
			led = 1'B0;
	end            //Module 3, describes the output of status register.

endmodule

