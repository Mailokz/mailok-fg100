module clk_div #(
    parameter DIV = 2
)(
    input  wire clk_in,
    input  wire rst,
    output reg  clk_out
);
    reg [7:0] counter;
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 8'd0;
            clk_out <= 1'b0;
        end else if (counter == DIV/2 - 1) begin
            counter <= 8'd0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1'b1;
        end
    end
endmodule