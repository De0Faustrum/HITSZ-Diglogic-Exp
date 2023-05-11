`timescale 1ns / 1ps

module led(
    input wire clk,
    input wire rst,
    input wire [11:0] entered_password,
    input wire [3:0] suffix,
    output reg [7:0] led_empower,
    output reg [7:0] led_ctrl
    );
    
    parameter MAX_2MS = 24'D199999;     //led empower signal iterates at the interval of 2ms
    parameter MAX_iteration = 4'D7;           //8 bit as the limit of led iteration 
    //parameter BIT_LENGTH = 3'B111;
    parameter LED_0=8'H03;
    parameter LED_1=8'H9F;
    parameter LED_2=8'H25;
    parameter LED_3=8'H0D;
    parameter LED_4=8'H99;
    parameter LED_5=8'H49;
    parameter LED_6=8'H41;
    parameter LED_7=8'H1F;
    parameter LED_8=8'H01;
    parameter LED_9=8'H09;
    parameter LED_F=8'H71;
    parameter LED_U=8'HFF;      //No bit lit
    
    reg [3:0] bit;              //Control what to display of each bit
    reg [23:0] cnt;             //Counter for 2ms
    reg [2:0] led_iteration;    //Iteration Status
    reg [0:0] iteration_flag;   //Control iteration, stimulated every 2ms
    
    initial begin
        bit = 4'H0; 
        cnt <= 24'D000000;
        led_iteration <= 3'B000;
        iteration_flag <= 1'B0;
    end

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            iteration_flag <= 0;
            cnt <= 0;
        end
        else if (cnt < MAX_2MS) begin
            iteration_flag <= 0;
            cnt <= cnt + 1;
        end
        else begin
            iteration_flag <= 1;
            cnt <= 0;
        end
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst == 1)
            led_iteration <= 0;
        else if (!iteration_flag)
            led_iteration <= led_iteration;
        else if (led_iteration < MAX_iteration)
            led_iteration <= led_iteration + 1;
        else 
            led_iteration <= 0;
    end
    
    always @ (posedge clk) begin
        case (led_iteration)
            3'B101: bit <= entered_password[3:0];
            3'B110: bit <= entered_password[7:4];
            3'B111: bit <= entered_password[11:8];
            default: bit <= suffix;
        endcase
    end
    
    always @ (posedge clk) begin        //Control enable signal
        case (led_iteration)
            3'B000:  led_empower = 8'B1111_1110;
            3'B001:  led_empower = 8'B1111_1101;
            3'B010:  led_empower = 8'B1111_1011;
            3'B011:  led_empower = 8'B1111_0111;
            3'B100:  led_empower = 8'B1110_1111;
            3'B101:  led_empower = 8'B1101_1111;
            3'B110:  led_empower = 8'B1011_1111;
            3'B111:  led_empower = 8'B0111_1111;
            default: led_empower = 8'B1111_1111;
        endcase
    end
    
    always @ (posedge clk) begin        //Control display signal
        case (bit)
            4'H0: led_ctrl <= LED_0;
            4'H1: led_ctrl <= LED_1;
            4'H2: led_ctrl <= LED_2;
            4'H3: led_ctrl <= LED_3;
            4'H4: led_ctrl <= LED_4;
            4'H5: led_ctrl <= LED_5;
            4'H6: led_ctrl <= LED_6;
            4'H7: led_ctrl <= LED_7;
            4'H8: led_ctrl <= LED_8;
            4'H9: led_ctrl <= LED_9;
            4'HF: led_ctrl <= LED_F;            
            default: led_ctrl <= LED_U;
        endcase
    end
endmodule