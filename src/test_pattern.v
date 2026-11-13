module test_pattern (
    input  wire clk,
    input  wire rst,
    input  wire video_on,
    input  wire [9:0] x,
    input  wire [9:0] y,
    output reg  [3:0] r,
    output reg  [3:0] g,
    output reg  [3:0] b
);
    // Pionowe paski co 64 piksele
    always @(*) begin
        if (!video_on) begin
            r = 4'h0; g = 4'h0; b = 4'h0;
        end else begin
            case (x[9:6])  // górne 4 bity X (0-9)
                4'd0: begin r = 4'hF; g = 4'hF; b = 4'hF; end // biały
                4'd1: begin r = 4'hF; g = 4'hF; b = 4'h0; end // żółty
                4'd2: begin r = 4'h0; g = 4'hF; b = 4'hF; end // cyjan
                4'd3: begin r = 4'h0; g = 4'hF; b = 4'h0; end // zielony
                4'd4: begin r = 4'hF; g = 4'h0; b = 4'hF; end // magenta
                4'd5: begin r = 4'hF; g = 4'h0; b = 4'h0; end // czerwony
                4'd6: begin r = 4'h0; g = 4'h0; b = 4'hF; end // niebieski
                4'd7: begin r = 4'h0; g = 4'h0; b = 4'h0; end // czarny
                4'd8: begin r = 4'h8; g = 4'h8; b = 4'h8; end // szary
                4'd9: begin r = 4'hF; g = 4'h8; b = 4'h0; end // pomarańczowy
                default: begin r = 4'h0; g = 4'h0; b = 4'h0; end
            endcase
        end
    end
endmodule