`timescale 1ns / 1ps

module tb_ham;

    reg clk;
    reg [4:1] d;
    reg en; // Enable signal for noise
    wire [1:7] c;
    wire [1:7] noise_out;
    wire [1:3] s;
    wire [1:7] c2;
    wire [1:4] d_out;

    // Instantiate the encoder
    encoder enc (
        .clk(clk),
        .d(d),
        .c(c)
    );

    // Instantiate the noise generator
    noise noise_gen (
        .en(en),
        .c(c),
        .noise_out(noise_out)
    );

    // Instantiate the decoder
    decoder dec (
        .clk(clk),
        .c_in(noise_out),
        .s(s),
        .c2(c2),
        .d(d_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $monitor("Time: %0t | d = %b | c = %b | noise_out = %b | s = %b | c2 = %b | d_out = %b | en = %b",
                 $time, d, c, noise_out, s, c2, d_out, en);
        d = 4'b0000; en = 0;
        @(posedge clk);
        d = 4'b1001; en = 1; @(posedge clk); // Introduce noise
        en = 0; @(posedge clk); // Disable noise
        d = 4'b0110; en = 1; @(posedge clk); // Introduce noise
        en = 0; @(posedge clk); // Disable noise
        #10 $finish;
    end

endmodule
