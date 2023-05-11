module multiplexer(
    input wire [0:0] enable,
    input wire [0:0] select,
    input wire [3:0] input_a,
    input wire [3:0] input_b,
    output reg [3:0] led
);

    always @ (*) begin
        if (enable == 1'b1) begin
            case(select)
                1'b0 : led = input_a + input_b;
                1'b1 : led = input_a - input_b;
                default : led = 4'b1111;
            endcase
        end
        else led = 4'b1111;
    end
endmodule