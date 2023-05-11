module lock(
    input wire clk,
    input wire rst,          //S1
    input wire encrypt,      //S2
    input wire decrypt,      //S3
    input wire ascertain,    //S5
    input  wire [3:0] row,
    output wire [3:0] col,
    output wire locked,
    output wire unlocked,
    output wire [2:0] fail_times,
    output wire [7:0] led_ctrl,
    output wire [7:0] led_empower    
    );
    
    wire keyboard_en;
    wire [3:0] keyboard_num;
    wire [15:0] keyboard_led;
    wire [11:0] entered_password;
    wire [3:0] suffix;
    

    keyboard u_keyboard(
        .clk (clk), 
        .reset (rst), 
        .row (row),
        .col (col),
        .keyboard_en (keyboard_en), 
        .keyboard_led (keyboard_led),
        .keyboard_num (keyboard_num)
    );
    
    password u_password(
        .clk (clk),
        .rst (rst),
        .encrypt (encrypt),
        .decrypt (decrypt),
        .ascertain (ascertain),
        .keyboard_en (keyboard_en),
        .keyboard_num (keyboard_num),
        .locked (locked),
        .unlocked (unlocked),
        .fail_times (fail_times),
        .entered_password(entered_password),
        .suffix(suffix)
    );   
        
    led u_led(
        .clk (clk),
        .rst (rst),
        .entered_password (entered_password),
        .suffix(suffix),
        .led_ctrl (led_ctrl),
        .led_empower (led_empower)
    );
    
    
endmodule
