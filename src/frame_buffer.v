module frame_buffer #(
    parameter WIDTH      = 256,
    parameter HEIGHT     = 192,
    parameter COLOR_BITS = 4       // 4 bity = 16 kolorów
)(
    input  wire clk,
    input  wire rst,

    // Port zapisu (z logiki rysującej)
    input  wire                     we,          // write enable
    input  wire [$clog2(WIDTH*HEIGHT)-1:0] write_addr,
    input  wire [COLOR_BITS-1:0]    write_data,

    // Port odczytu (do wyświetlania)
    input  wire [$clog2(WIDTH*HEIGHT)-1:0] read_addr,
    output reg  [COLOR_BITS-1:0]    read_data
);

    // Pamięć: 256*192 = 49152 komórek po 4 bity
    reg [COLOR_BITS-1:0] mem [0:WIDTH*HEIGHT-1];

    // Zapis i odczyt synchroniczny (typowy BRAM)
    always @(posedge clk) begin
        if (we) begin
            mem[write_addr] <= write_data;
        end
        read_data <= mem[read_addr];
    end

endmodule