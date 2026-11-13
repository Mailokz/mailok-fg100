`timescale 1ns/1ps

module tb_blink;

    reg  clk;
    reg  rst;
    wire led;

    blink #(.MAX(5)) dut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    initial clk = 0;
    always #18.5 clk = ~clk;  // 27 MHz

    initial begin
        $dumpfile("tb_blink.vcd");
        $dumpvars(0, tb_blink);

        rst = 1;
        #100 rst = 0;

        #2000;
        $display("Koniec symulacji, led = %b", led);
        $finish;
    end

endmodule