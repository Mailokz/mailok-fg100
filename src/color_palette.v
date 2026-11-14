module color_palette (
    input  wire [3:0]  color_idx,
    output reg  [11:0] rgb        // {R[3:0], G[3:0], B[3:0]}
);
    always @(*) begin
        case (color_idx)
            4'h0: rgb = 12'h000; // czarny
            4'h1: rgb = 12'h00F; // niebieski
            4'h2: rgb = 12'h0F0; // zielony
            4'h3: rgb = 12'h0FF; // cyjan
            4'h4: rgb = 12'hF00; // czerwony
            4'h5: rgb = 12'hF0F; // magenta
            4'h6: rgb = 12'hF80; // pomarańczowy
            4'h7: rgb = 12'hFFF; // biały
            4'h8: rgb = 12'h888; // szary
            4'h9: rgb = 12'h88F; // jasnoniebieski
            4'hA: rgb = 12'h8F8; // jasnozielony
            4'hB: rgb = 12'h8FF; // jasnocyjan
            4'hC: rgb = 12'hF88; // jasnoczerwony
            4'hD: rgb = 12'hF8F; // różowy
            4'hE: rgb = 12'hFF8; // żółty
            4'hF: rgb = 12'hFFF; // biały
        endcase
    end
endmodule

