module rf_decoder (
    input  clk2x, din,
    output manch_out, manch_error,
    output miller_out, miller_error,
    output fmiller_out, fmiller_error
);

    miller_decoder(
        .clk2x(clk2x),
        .din(din), 
        .enable(1),
        .dout(miller_out), 
        .error(miller_error)
    );
    
endmodule