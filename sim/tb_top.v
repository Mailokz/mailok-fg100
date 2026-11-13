`timescale 1ns/1ps

module tb_top;
    reg clk, rst;
    wire hdmi_clk, hdmi_hsync, hdmi_vsync, hdmi_de;
    wire [3:0] hdmi_r, hdmi_g, hdmi_b;

    top dut (
        .clk(clk), .rst(rst),
        .hdmi_clk(hdmi_clk),
        .hdmi_hsync(hdmi_hsync),
        .hdmi_vsync(hdmi_vsync),
        .hdmi_de(hdmi_de),
        .hdmi_r(hdmi_r), .hdmi_g(hdmi_g), .hdmi_b(hdmi_b)
    );

    // Zegar 27 MHz
    initial clk = 0;
    always #18.5 clk = ~clk;

    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
        rst = 1;
        #100 rst = 0;
        #1000000; // symuluj chwilę
        $display("Koniec symulacji");
        $finish;
    end
endmodule