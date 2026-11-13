module top (
    input  wire clk,       // 27 MHz z płytki
    input  wire rst,       // przycisk reset
    output wire hdmi_clk,  // zegar pikseli (do HDMI)
    output wire hdmi_hsync,
    output wire hdmi_vsync,
    output wire hdmi_de,   // data enable
    output wire [3:0] hdmi_r,
    output wire [3:0] hdmi_g,
    output wire [3:0] hdmi_b
);
    wire clk_pix;
    wire [9:0] x, y;
    wire video_on;
    wire [3:0] r, g, b;

    // Dzielnik zegara: 27 MHz -> 13.5 MHz (na razie, potem PLL)
    clk_div #(.DIV(2)) clkdiv (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_pix)
    );

    // Generator timingów
    vga_timing timing (
        .clk(clk_pix),
        .rst(rst),
        .hsync(hdmi_hsync),
        .vsync(hdmi_vsync),
        .video_on(video_on),
        .x(x),
        .y(y)
    );

    // Wzór testowy
    test_pattern pattern (
        .clk(clk_pix),
        .rst(rst),
        .video_on(video_on),
        .x(x),
        .y(y),
        .r(r),
        .g(g),
        .b(b)
    );

    // Wyjścia
    assign hdmi_clk = clk_pix;
    assign hdmi_de = video_on;
    assign hdmi_r = r;
    assign hdmi_g = g;
    assign hdmi_b = b;
endmodule