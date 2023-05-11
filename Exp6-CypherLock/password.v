`timescale 1ns / 1ps

module password(
    input wire clk,
    input wire rst,             //button S1
    input wire encrypt,         //button S2
    input wire decrypt,         //button S3
    input wire ascertain,       //button S5
    input wire keyboard_en,
    input wire [3:0]  keyboard_num,
    output reg [11:0] entered_password, //Marks already entered bits
    output reg [3:0]  suffix,           //Marks last bits 
    output reg locked,
    output reg unlocked,
    output reg [2:0] fail_times
    );
    
    reg [3:0] current_status;
    reg [3:0] next_status;
    reg [1:0] input_status;
    reg [11:0] current_password;
    reg [2:0] matching_status;
    reg [2:0] password_cnt;
    reg end_oi;                                 //End of keyboard input

    initial begin
        entered_password = 12'H000;
        suffix = 4'H0;
        locked = 0;
        unlocked = 1;
        fail_times = 3'B000;
        current_status = 4'B0000;
        next_status = 4'B0000;
        input_status = 2'B00;
        current_password = 12'H000;
        
    end

    always @ (posedge clk or posedge rst) begin
        if (rst)
            current_status <= 4'B0000;
        else
            current_status <= next_status;
    end         //When clock edge comes, status switch occurs
        
    always @ (posedge clk) begin
        if (rst)
            next_status <= 4'B0000;
        else
            case (current_status)
                4'B0000 : if (encrypt)
                              next_status <= 4'B0001;               //Encrypt mode
                4'B0001 : if (ascertain && input_status == 3)
                              next_status <= 4'B0010;               //Encrypt accomplished
                4'B0010 : if (decrypt)
                              next_status <= 4'B0011;               //Decrypt mode 1st
                4'B0011 : if (matching_status == 3 && end_oi)
                              next_status <= 4'B1010;               //Success in 1st trial
                          else if (matching_status != 3 && end_oi)
                              next_status <= 4'B0100;               //Failed once
                4'B0100 : if (decrypt)
                              next_status <= 4'B0101;               //Decrypt mode 2nd
                4'B0101 : if (matching_status == 3 && end_oi)
                              next_status <= 4'B1010;               //Success in 2nd trial
                          else if (matching_status != 3 && end_oi)
                              next_status <= 4'B0110;               //Failed twice
                4'B0110 : if (decrypt)
                              next_status <= 4'B0111;               //Decrypt mode 3rd
                4'B0111 : if (matching_status == 3 && end_oi)
                              next_status <= 4'B1010;               //Success in 3rd trial
                          else if (matching_status != 3 && end_oi)
                              next_status <= 4'B1000;               //Failed thrice, system locked
                4'B1010 : if (encrypt)
                              next_status <= 4'B0001;               //Recrypt password
                default : next_status <= current_status;                                                       
            endcase
    end
    
    always @ (posedge rst or posedge clk) begin
        if (rst || !current_status[0])
            input_status <= 0;
        else if (keyboard_en && input_status < 3 && current_status[0])
            input_status <= input_status + 1;    //Count input bits
    end
   
    always @ (posedge rst or posedge clk) begin
        if (rst) begin
            entered_password <= 12'H000;
            suffix <= 4'H0;                 //Reset Display signal
        end
        else if (keyboard_en && current_status[0])
            case (input_status)
                2'B00: entered_password[11:8] <= keyboard_num;      //1 bits
                2'B01: entered_password[7:4]  <= keyboard_num;      //2 bits
                2'B10: entered_password[3:0]  <= keyboard_num;      //3 bits
                default: entered_password <= entered_password;
            endcase
        else if (current_status[0]) begin
            suffix <= 4'HA;                                         //Suffix all extinguished
            case (input_status)
                2'B00: entered_password[11:0] <= 12'HAAA;           //0 bits entered      
                2'B01: entered_password[7:0] <= 8'HAA;              //1 bits entered
                2'B10: entered_password[3:0] <= 4'HA;               //2 bits entered
                default: suffix <= 4'HA;
            endcase
        end
        else if (current_status == 4'B1000)  
            {entered_password,suffix} <= 16'HFFFF;                  //Failed thrice, all bits 'F'
        else
            {entered_password,suffix} <= 16'H0000;                  //Default display 0
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst)
            current_password <= 12'h000;                            //Reset entered password
        else if (current_status == 4'B0001 && ascertain)            
            current_password <= entered_password;                   //Assign password
     end
    
    always @ (posedge clk or posedge rst) begin
        if (rst || !current_status[0])
            password_cnt <= 7;                                      //Reset password counter
        else if (ascertain && input_status == 3 && current_status != 4'B0001)
            password_cnt <= 0;                                      
        else if (password_cnt < 7)
            password_cnt <= password_cnt + 1;                       //Self addition
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst || !current_status[0]) begin
            matching_status <= 7;                                   //Reset matching automata
            end_oi <= 0;
        end
        else if (ascertain && input_status == 3 && current_status != 4'B0001) begin
            matching_status <= 0;
            end_oi <= 0;                                           //ascertain and reset automata  
        end
        else if (password_cnt != 7)
            case (password_cnt)     //Finite State Automata For Password Matching
                3'B000: if (entered_password[11:8] == current_password[11:8])
                       matching_status <= matching_status + 1;
                3'B001: if (entered_password[7:4] == current_password[7:4])
                       matching_status <= matching_status + 1;
                3'B010: if (entered_password[3:0] == current_password[3:0])
                       matching_status <= matching_status + 1;
                3'B011: end_oi <= 1;     //End of keybord input
                default: matching_status <= matching_status;
            endcase
    end  
        
    always @ (posedge clk) begin 
        case (current_status)       //Assign 5 LED for each status
            4'B0000,4'B0001:{locked,unlocked,fail_times} <= 5'B00000;
            4'B0010,4'B0011:{locked,unlocked,fail_times} <= 5'B10000;
            4'B0100,4'B0101:{locked,unlocked,fail_times} <= 5'B10100;
            4'B0110,4'B0111:{locked,unlocked,fail_times} <= 5'B10110;
            4'B1000,4'B1001:{locked,unlocked,fail_times} <= 5'B10111;
            4'B1010,4'B1011:{locked,unlocked,fail_times} <= 5'B11000; 
            default        :{locked,unlocked,fail_times} <= 5'B00000;
        endcase
    end
 
endmodule
