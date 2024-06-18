module noise (
    input en,
    input [1:7] c,
    output reg [1:7] noise_out
);
    always @(*) begin
        noise_out = c; // Start by copying c to noise_out
        if (en)
            noise_out[3] = ~c[3]; // Toggle bit c[3] if en is high
    end
endmodule
