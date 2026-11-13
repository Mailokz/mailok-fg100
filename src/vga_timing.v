module vga_timing (
    input  wire clk,       // 25 MHz (lub 27 MHz z Tang Nano)
    input  wire rst,
    output reg  hsync,
    output reg  vsync,
    output reg  video_on,  // 1 = rysuj piksel, 0 = poza ekranem
    output reg  [9:0] x,   // współrzędna X (0-639)
    output reg  [9:0] y    // współrzędna Y (0-479)
);
    // Parametry 640x480@60Hz
    localparam H_VISIBLE = 640;
    localparam H_FRONT   = 16;
    localparam H_SYNC    = 96;
    localparam H_BACK    = 48;
    localparam H_TOTAL   = H_VISIBLE + H_FRONT + H_SYNC + H_BACK; // 800

    localparam V_VISIBLE = 480;
    localparam V_FRONT   = 10;
    localparam V_SYNC    = 2;
    localparam V_BACK    = 33;
    localparam V_TOTAL   = V_VISIBLE + V_FRONT + V_SYNC + V_BACK; // 525

    reg [9:0] h_count, v_count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            h_count <= 10'd0;
            v_count <= 10'd0;
        end else begin
            if (h_count == H_TOTAL - 1) begin
                h_count <= 10'd0;
                if (v_count == V_TOTAL - 1)
                    v_count <= 10'd0;
                else
                    v_count <= v_count + 1'b1;
            end else begin
                h_count <= h_count + 1'b1;
            end
        end
    end

    // Sygnały synchronizacji (aktywne w stanie niskim)
    always @(*) begin
        hsync = ~(h_count >= H_VISIBLE + H_FRONT && h_count < H_VISIBLE + H_FRONT + H_SYNC);
        vsync = ~(v_count >= V_VISIBLE + V_FRONT && v_count < V_VISIBLE + V_FRONT + V_SYNC);
        video_on = (h_count < H_VISIBLE) && (v_count < V_VISIBLE);
        x = h_count;
        y = v_count;
    end
endmodule