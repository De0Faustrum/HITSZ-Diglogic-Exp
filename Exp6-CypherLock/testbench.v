`timescale 1ns / 1ps

module testbench();
    reg       clk;
    reg       rst;
    reg       encrypt;
    reg       decrypt;
    reg       ascertain;
    reg  [3:0]row; 
    reg  [2:0] failed_times;
    reg  [1:0] matching_status;
    wire [3:0] col;
    wire locked;
    wire unlocked;
    wire [2:0] fail_times;
    wire [7:0] led_ctrl;
    wire [7:0] led_empower;

    always #5 clk =~clk;
     
    initial begin
        #0   clk=1'B1;rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;row=4'B1111;locked1=1'B0;unlocked1=1'B0;failed_times=3'B0;matching_status=1'B0;
        #10  rst = 1;
        #10  rst = 0;
        #70  rst =1'B0;encrypt=1'B1;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #70  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0; 
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #70  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B1;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B1;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #30  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B01;row=4'B0111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0; 
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B01;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B10;row=4'B0111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B10;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #40  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #110 rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B1;matching_status=2'B00;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B1;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #30  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B01;row=4'B0111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0; 
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B01;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B100;locked1=1'B1;unlocked1=1'B0;
        #110 rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B1;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B1;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #50  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0; 
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B110;locked1=1'B1;unlocked1=1'B0;
        #110 rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B1;matching_status=2'B00;row=4'B1111;failed_times=3'B111;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B111;locked1=1'B1;unlocked1=1'B0;
        #100 rst =1'B1;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;    
        #70  rst =1'B0;encrypt=1'B1;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #70  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0; 
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B0111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B0;unlocked1=1'B0;
        #70  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B1;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #60  rst =1'B0;encrypt=1'B0;decrypt=1'B1;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B00;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #30  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B01;row=4'B0111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B01;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B10;row=4'B0111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B10;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #80  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B11;row=4'B0111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #20  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B11;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B0;
        #70  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B1;matching_status=2'B11;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B1;
        #10  rst =1'B0;encrypt=1'B0;decrypt=1'B0;ascertain=1'B0;matching_status=2'B11;row=4'B1111;failed_times=3'B000;locked1=1'B1;unlocked1=1'B1;
        #240 $finish;
     end
    
    lock lock_1 (
        .clk      (clk),
        .rst      (rst),
        .encrypt     (encrypt),
        .decrypt    (decrypt),
        .ascertain  (ascertain),
        .row      (row),
        .col      (col),      
        .locked (locked),
        .unlocked  (unlocked),    
        .fail_times(fail_times),         
        .led_ctrl(led_ctrl),
        .led_empower   (led_empower)
    );
    reg locked1;
    reg unlocked1;
endmodule