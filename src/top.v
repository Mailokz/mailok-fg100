module top (
    input  wire clk,       // 27 MHz z płytki
    input  wire rst,       // przycisk reset
    output wire hdmi_clk,  // zegar pikseli
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

    // --- Sygnały do bufora klatki ---
    wire        we;
    wire [15:0] write_addr;
    wire [3:0]  write_data;
    wire [15:0] read_addr;
    wire [3:0]  read_data;

    // --- Dzielnik zegara ---
    clk_div #(.DIV(2)) clkdiv (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_pix)
    );

    // --- Generator timingów ---
    vga_timing timing (
        .clk(clk_pix),
        .rst(rst),
        .hsync(hdmi_hsync),
        .vsync(hdmi_vsync),
        .video_on(video_on),
        .x(x),
        .y(y)
    );

    // --- Adres odczytu z bufora ---
    // Tylko gdy jesteśmy w obszarze 256x192. W przeciwnym razie czytamy 0.
    assign read_addr = (x < 256 && y < 192) ? {y[7:0], x[7:0]} : 16'd0;

    // --- Bufor klatki (BRAM) ---
    frame_buffer fb (
        .clk(clk_pix),
        .rst(rst),
        .we(we),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr(read_addr),
        .read_data(read_data)
    );

        // --- Wypełnianie pamięci wzorem szachownicy ---
    reg [15:0] write_counter;
    reg        writing;

    always @(posedge clk_pix or posedge rst) begin
        if (rst) begin
            write_counter <= 16'd0;
            writing <= 1'b1;
        end else if (writing) begin
            if (write_counter == 16'd49151) begin
                writing <= 1'b0;
            end else begin
                write_counter <= write_counter + 1'b1;
            end
        end
    end

    wire [7:0] cx = write_counter[7:0];   // niskie 8 bitów = x (0..255)
    wire [7:0] cy = write_counter[15:8];  // wysokie 8 bitów = y (0..191)
    wire checker = (cx[7:4] ^ cy[7:4]) & 1;  // XOR górnych 4 bitów

    assign we         = writing;
    assign write_addr = write_counter;
    assign write_data = checker ? 4'h7 : 4'h0;  // biały lub czarny

    // --- Wyświetlanie ---
    // Jeśli jesteśmy w obszarze 256x192, pokazujemy kolor z bufora.
    // Jeśli nie, pokazujemy czarny (0).
    assign hdmi_clk = clk_pix;
    assign hdmi_de  = video_on;
    
    // --- Paleta kolorów ---
    wire [11:0] rgb_out;
    color_palette palette (
        .color_idx((x < 256 && y < 192) ? read_data : 4'h0),
        .rgb(rgb_out)
    );

    assign hdmi_r = rgb_out[11:8];
    assign hdmi_g = rgb_out[7:4];
    assign hdmi_b = rgb_out[3:0];

endmodule
