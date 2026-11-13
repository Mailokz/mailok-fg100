module blink #(
    parameter MAX = 13_500_000  // dla 27 MHz -> ~2 Hz miganie
)(
    input  wire clk,
    input  wire rst,
    output reg  led
);

    reg [23:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 24'd0;
            led     <= 1'b0;
        end else if (counter == MAX - 1) begin
            counter <= 24'd0;
            led     <= ~led;
        end else begin
            counter <= counter + 1'b1;
        end
    end

endmodule